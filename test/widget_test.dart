// The root widget needs Firebase, so it is covered by integration tests.
// Domain logic is covered by the tests in test/unit.
import 'package:flutter_test/flutter_test.dart';
import 'package:table_next_pro/core/config/app_config.dart';
import 'package:table_next_pro/core/responsive/breakpoints.dart';

void main() {
  test('configuration sanity', () {
    expect(AppConfig.pinLength, inInclusiveRange(4, 6));
    expect(Breakpoints.fromWidth(390), ScreenSize.compact);
    expect(Breakpoints.fromWidth(820), ScreenSize.medium);
    expect(Breakpoints.fromWidth(1366), ScreenSize.expanded);
  });
}
