# TableNext Pro

Multi-tenant restaurant **reservations, live floor plan, customers and billing** app built with Flutter, Riverpod 3 (generator), Freezed 3, Hive and Cloud Firestore. Designed tablet-first, fully responsive (phone · tablet · desktop) with light & dark themes.

---

## 1. Getting started

```bash
# 1. Dependencies
flutter pub get

# 2. Code generation (freezed / json_serializable / riverpod_generator)
dart run build_runner build -d          # or: watch -d while developing

# 3. Firebase (generates lib/firebase_options.dart — replaces the placeholder)
dart pub global activate flutterfire_cli
flutterfire configure --project=<your-firebase-project-id>

# 4. Deploy Firestore rules (no composite indexes are required)
firebase deploy --only firestore:rules

# 5. Run — the provisioning code protects "Set up a new restaurant"
flutter run --dart-define=TNP_PROVISIONING_CODE=CHOOSE-A-SECRET
```

> In **debug builds** provisioning works without a code. In **release builds** the "Set up a new restaurant" button only appears when `TNP_PROVISIONING_CODE` is defined.

### Platform notes
| Platform | Action |
|---|---|
| iOS | Firebase SDK 12 needs iOS 15: in `ios/Podfile` set `platform :ios, '15.0'`. |
| macOS | Add `com.apple.security.network.client` (true) to `macos/Runner/DebugProfile.entitlements` and `Release.entitlements`; set `platform :osx, '10.15'` in `macos/Podfile`. For secure storage add a `keychain-access-groups` entitlement (the app falls back to Hive if the keychain is unavailable). |
| Android | `minSdk` 23+ (Flutter default is fine). |
| Printing | Receipts use the `printing` package (AirPrint / Android print service / desktop dialogs; 80 mm roll format). |

---

## 2. How sign-in works (no Firebase Auth)

1. **Device activation (once per device):** staff enters *username + PIN*. The app finds the user in the global `users` collection, verifies the salted SHA-256 PIN hash, reads the user's `businessId` and stores the link in secure storage.
2. **PIN lock (every time):** the device shows a PIN pad for the linked business. Any active staff member unlocks with **their own PIN** (verified against Firestore; works offline from cache). PINs are unique per business.
3. **Auto-lock** after inactivity (configurable per device: never / 1–30 min) and a manual **Lock** button. 5 wrong PINs → 30 s cooldown.
4. **Roles:** Owner, Manager, Host, Cashier, Waiter → permission matrix in `features/auth/domain/entities/user_role.dart`.

The first business + owner is created from **Activation → "Set up a new restaurant"** (protected by the provisioning code). Ship the same app to many restaurants; each gets its own `businessId`.

---

## 3. Architecture

Feature-first, clean layering:

```
lib/
├── app/                 # App widget, adaptive shell (bottom bar / rail / sidebar), splash, auto-lock
├── core/                # Theme (tokens, palette, light/dark), responsive breakpoints, router,
│                        # services (Hive, secure storage, Talker, connectivity), shared widgets,
│                        # Firestore helpers (guards, converters, daily stats writer), utils
└── features/
    ├── auth/            # Activation, PIN lock, session, staff & PIN management
    ├── business/        # Restaurant profile (currency, VAT, service charge, hours)
    ├── floor_plan/      # Floor editor (tables + structures), live floor status
    ├── reservations/    # Reservations list / timeline, booking form, availability engine
    ├── customers/       # Paged directory, search, profile & history, autocomplete
    ├── menu/            # Categories & items
    ├── billing/         # POS, split payments, discounts, receipts (PDF), history
    ├── dashboard/       # KPIs, 7-day revenue, arrivals
    └── settings/        # Appearance, security, device, diagnostics
        each feature: domain/ (entities, repositories, services)
                      data/   (models + mappers, datasources, repository impls)
                      presentation/ (controllers, screens, widgets)
```

* **State:** Riverpod 3 with `riverpod_generator` (`@riverpod`).
* **Models:** Freezed 3 entities (domain) + Freezed/JSON models (data) with explicit mappers.
* **Local storage:** Hive (`hive` + `hive_flutter`, JSON maps — no adapters/`hive_generator` needed) for preferences & caches; `flutter_secure_storage` for the device ↔ business link.
* **Logging:** Talker (+ Riverpod observer). Owners can open *Settings → Diagnostics*.
* **Offline-first:** Firestore persistence (unlimited cache). Writes are applied locally and synced later; the UI never blocks on the network.

---

## 4. Firestore data model

```
users/{userId}                         businessId, name, username, role, pinHash, active, lastLoginAt
businesses/{businessId}                name, phone, address, currencyCode/Symbol, taxRate, serviceChargeRate, …
  ├─ customers/{id}                    name, phone, phoneNormalized, nameLower, email, tags, isVip,
  │                                    visitCount, reservationCount, noShowCount, totalSpent, lastVisitAt
  ├─ reservations/{id}                 customer*, partySize, startAt, endAt, durationMinutes,
  │                                    tableIds, tableLabels, status, source, occasion, notes, billId
  ├─ floors/{id}                       name, sortOrder, width, height
  ├─ floor_elements/{id}               floorId, kind(table|structure), tableShape, structureType,
  │                                    label, seats, x, y, width, height, rotation
  ├─ menu_categories/{id}, menu_items/{id}
  ├─ bills/{id}                        billNumber, status, orderType, tables, customer, items[],
  │                                    discount, taxRate, serviceChargeRate, totals, payments[]
  ├─ daily_stats/{yyyy-MM-dd}          revenue, bills, guests, reservations, covers, payment split…
  └─ counters/bills                    next (sequential bill numbers)
```

### Built for the free Spark plan (17k+ customers)
* Customer list reads **25 docs per page** ordered by `updatedAt` (infinite scroll).
* Search = **prefix query** on `phoneNormalized` (digits) or `nameLower`, max 8–30 docs.
* Dashboard reads **7 aggregate docs** (`daily_stats`), maintained with atomic increments when bills are paid / reservations created — never scans bills.
* Every query uses a single ordered field → **no composite indexes**.
* **Imported customers?** Run *Settings → Rebuild customer search index* once after importing. It adds `phoneNormalized`, `nameLower` and `updatedAt` to old documents (≈1 read per customer + writes only where needed).

---

## 5. Features

* **Floor plan editor** — round / rectangle / square tables whose size grows with the chair count; drag & drop with snap-to-grid, orientation, duplicate, undo (Ctrl/Cmd+Z), save (Ctrl/Cmd+S); structures: kitchen, bar, register, host stand, entrance, restroom, stage, buffet, storage, stairs, walls, windows, pillars, plants, zones; multiple floors with canvas sizes.
* **Live floor** — tables coloured by status (available / reserved within 1 h / occupied), timers, next booking, walk-in seating, seat reservation → opens bill.
* **Reservations** — day strip, list grouped by hour or **timeline per table** (tap an empty slot to book), statuses (pending → confirmed → seated → completed, cancelled, no-show), late badges.
* **Booking form** — phone/name autocomplete fills guest details, returning-guest insight with previous reservations, floor-plan table picker with conflict detection, auto-assign (smallest fit or best combination), double-booking guard.
* **Customers** — paged directory, search, VIP, tags, birthday, notes, visits, spend, no-show warning, reservation & bill history, call button.
* **Billing / POS** — dine-in / takeaway / delivery, menu grid with search & codes, line notes, quantity stepper, % or fixed discount, service charge toggle, VAT, split payments (cash / card / mobile banking / other with TrxID), quick-cash & change, sequential bill numbers, void with reason (manager), 80 mm PDF receipt print/share, daily history with totals.
* **Dashboard** — revenue, reservations/covers, occupancy, open bills, 7-day chart, payment split, arrivals.
* **Settings** — light / dark / system theme, auto-lock, restaurant profile, staff & PINs, device deactivation, diagnostics.

---

## 6. Security caveat (please read)

Without Firebase Authentication, Firestore cannot verify *who* sends a request; anyone who extracts your Firebase config from the app could query the database. The included `firestore.rules` restrict collections, validate key documents and block destructive deletes, but **enable Firebase App Check** before going live, and consider moving PIN verification to a Cloud Function (Blaze plan) or adding anonymous/custom auth later — the repository layer is already isolated so this can be swapped in without touching the UI.

---

## 7. Tests

```bash
flutter test
```
Unit tests cover bill maths, table geometry, availability/auto-assign, phone normalisation and PIN hashing.
