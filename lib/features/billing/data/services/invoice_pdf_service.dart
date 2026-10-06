import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/utils/formatters.dart';
import '../../../business/domain/entities/business.dart';
import '../../domain/entities/bill.dart';

/// Builds an 80mm thermal-receipt style PDF for a bill and hands it to the
/// platform print / share dialog.
class InvoicePdfService {
  const InvoicePdfService();

  Future<Uint8List> build(Bill bill, Business business) async {
    pw.ThemeData theme;
    try {
      theme = pw.ThemeData.withFont(
        base: await PdfGoogleFonts.notoSansRegular(),
        bold: await PdfGoogleFonts.notoSansBold(),
      );
    } catch (_) {
      theme = pw.ThemeData(); // Offline: built-in Helvetica.
    }

    // Built-in / Latin fonts may not contain local currency glyphs (e.g. ৳),
    // so the ISO code is used on paper.
    final symbol = business.currencySymbol.codeUnits.every((c) => c < 128)
        ? business.currencySymbol
        : '${business.currencyCode} ';
    String money(num v) => Formatters.money(v, symbol: symbol);

    final doc = pw.Document(title: 'Bill ${bill.billNumber}', author: business.name);
    const small = pw.TextStyle(fontSize: 8);
    const normal = pw.TextStyle(fontSize: 9);
    final bold = pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold);

    pw.Widget row(String l, String r, {pw.TextStyle? style}) => pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 1),
          child: pw.Row(
            children: [
              pw.Expanded(child: pw.Text(l, style: style ?? normal)),
              pw.Text(r, style: style ?? normal),
            ],
          ),
        );

    pw.Widget divider() => pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 4),
          child: pw.Divider(thickness: 0.5, borderStyle: pw.BorderStyle.dashed),
        );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        theme: theme,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Text(
              business.name,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
            ),
            if (business.address.isNotEmpty)
              pw.Text(business.address, textAlign: pw.TextAlign.center, style: small),
            if (business.phone.isNotEmpty)
              pw.Text('Tel: ${business.phone}', textAlign: pw.TextAlign.center, style: small),
            divider(),
            row('Bill #', bill.billNumber, style: bold),
            row('Date', Formatters.dateTime(bill.closedAt ?? bill.createdAt ?? DateTime.now())),
            row('Type', bill.orderType.label),
            if (bill.tableLabels.isNotEmpty) row('Table', bill.tableLabels.join(', ')),
            row('Guests', '${bill.guests}'),
            if (bill.customerName.isNotEmpty) row('Customer', bill.customerName),
            if (bill.openedByName.isNotEmpty) row('Served by', bill.openedByName),
            divider(),
            for (final item in bill.items) ...[
              pw.Text(item.name, style: bold),
              row('  ${item.quantity} × ${money(item.unitPrice)}', money(item.total)),
              if (item.note.isNotEmpty) pw.Text('  * ${item.note}', style: small),
            ],
            divider(),
            row('Subtotal', money(bill.totals.subtotal)),
            if (bill.totals.discount > 0) row('Discount', '-${money(bill.totals.discount)}'),
            if (bill.totals.serviceCharge > 0)
              row('Service (${_pct(bill.serviceChargeRate)}%)', money(bill.totals.serviceCharge)),
            if (bill.totals.tax > 0) row('VAT (${_pct(bill.taxRate)}%)', money(bill.totals.tax)),
            pw.SizedBox(height: 2),
            row('TOTAL', money(bill.totals.total), style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            if (bill.payments.isNotEmpty) ...[
              divider(),
              for (final p in bill.payments) row(p.method.label, money(p.amount)),
            ],
            if (bill.status == BillStatus.voided) ...[
              divider(),
              pw.Text('*** VOID ***', textAlign: pw.TextAlign.center, style: bold),
              if (bill.voidReason.isNotEmpty)
                pw.Text(bill.voidReason, textAlign: pw.TextAlign.center, style: small),
            ],
            divider(),
            pw.Text(business.billFooter, textAlign: pw.TextAlign.center, style: small),
            pw.SizedBox(height: 4),
            pw.Text('Powered by TableNext Pro', textAlign: pw.TextAlign.center, style: const pw.TextStyle(fontSize: 6)),
          ],
        ),
      ),
    );
    return doc.save();
  }

  static String _pct(double v) => v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1);

  Future<void> printBill(Bill bill, Business business) async {
    final bytes = await build(bill, business);
    await Printing.layoutPdf(
      name: 'Bill-${bill.billNumber}',
      format: PdfPageFormat.roll80,
      onLayout: (_) async => bytes,
    );
  }

  Future<void> shareBill(Bill bill, Business business) async {
    final bytes = await build(bill, business);
    await Printing.sharePdf(bytes: bytes, filename: 'Bill-${bill.billNumber}.pdf');
  }
}
