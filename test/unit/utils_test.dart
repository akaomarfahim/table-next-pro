import 'package:flutter_test/flutter_test.dart';
import 'package:table_next_pro/core/utils/phone_utils.dart';
import 'package:table_next_pro/core/utils/pin_hasher.dart';

void main() {
  group('PhoneUtils', () {
    test('normalises Bangladesh numbers with country code', () {
      expect(PhoneUtils.normalize('+880 1712-345678'), '01712345678');
      expect(PhoneUtils.normalize('01712 345 678'), '01712345678');
    });

    test('detects phone-like queries', () {
      expect(PhoneUtils.looksLikePhone('0171'), isTrue);
      expect(PhoneUtils.looksLikePhone('Rahim'), isFalse);
    });
  });

  group('PinHasher', () {
    test('verifies the right PIN only', () {
      final hash = PinHasher.hash(userId: 'u1', pin: '4821');
      expect(PinHasher.verify(userId: 'u1', pin: '4821', expectedHash: hash), isTrue);
      expect(PinHasher.verify(userId: 'u1', pin: '4822', expectedHash: hash), isFalse);
      expect(PinHasher.verify(userId: 'u2', pin: '4821', expectedHash: hash), isFalse);
    });

    test('rejects weak PINs', () {
      expect(PinHasher.validate('1111'), isNotNull);
      expect(PinHasher.validate('1234'), isNotNull);
      expect(PinHasher.validate('4821'), isNull);
    });
  });
}
