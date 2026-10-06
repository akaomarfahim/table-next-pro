import 'package:flutter_test/flutter_test.dart';
import 'package:table_next_pro/features/floor_plan/domain/entities/floor_enums.dart';
import 'package:table_next_pro/features/floor_plan/domain/services/table_geometry.dart';

void main() {
  group('TableGeometry', () {
    for (final shape in TableShape.values) {
      test('${shape.name}: one chair per seat', () {
        for (final seats in [1, 2, 4, 7, 10, 16]) {
          expect(TableGeometry.layout(shape, seats).chairs, hasLength(seats));
        }
      });

      test('${shape.name}: table grows with seats', () {
        final small = TableGeometry.sizeFor(shape, 2);
        final large = TableGeometry.sizeFor(shape, 12);
        expect(large.width * large.height, greaterThan(small.width * small.height));
      });
    }

    test('chairs stay inside the element bounds', () {
      for (final shape in TableShape.values) {
        final layout = TableGeometry.layout(shape, 10);
        for (final c in layout.chairs) {
          expect(c.center.dx, inInclusiveRange(0, layout.size.width));
          expect(c.center.dy, inInclusiveRange(0, layout.size.height));
        }
      }
    });
  });
}
