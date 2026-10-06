/// Phone number normalisation used for storage, de-duplication and prefix
/// search. The normalised form contains digits only.
///
/// Bangladesh numbers written with the country code (`+8801XXXXXXXXX`) are
/// folded into their local form (`01XXXXXXXXX`) so both spellings match.
abstract final class PhoneUtils {
  static final RegExp _nonDigits = RegExp(r'\D');

  static String normalize(String input) {
    var digits = input.replaceAll(_nonDigits, '');
    if (digits.startsWith('880') && digits.length == 13) {
      digits = digits.substring(2);
    }
    return digits;
  }

  static bool looksLikePhone(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return false;
    return RegExp(r'^\+?[\d\s-]+$').hasMatch(trimmed);
  }

  static bool isValid(String input) {
    final n = normalize(input);
    return n.length >= 6 && n.length <= 15;
  }

  /// Pretty prints an 11 digit local number as `01712-345678`.
  static String display(String input) {
    final n = normalize(input);
    if (n.length == 11 && n.startsWith('01')) {
      return '${n.substring(0, 5)}-${n.substring(5)}';
    }
    return input;
  }
}
