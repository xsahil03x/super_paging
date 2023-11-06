import 'package:flutter_test/flutter_test.dart';
import 'package:super_pager/src/two_part_list.dart';

void main() {
  group('TwoPartList', () {
    test('should return the correct length', () {
      final topList = [1, 2, 3];
      final bottomList = [4, 5, 6];
      final twoPartList = TwoPartList<int>(top: topList, bottom: bottomList);

      expect(twoPartList.length, equals(6));
    });

    test('should retrieve elements correctly', () {
      final topList = [1, 2, 3];
      final bottomList = [4, 5, 6];
      final twoPartList = TwoPartList<int>(top: topList, bottom: bottomList);

      expect(twoPartList[0], equals(1));
      expect(twoPartList[3], equals(4));
      expect(twoPartList[5], equals(6));
    });

    test('should throw RangeError for invalid index', () {
      const twoPartList = TwoPartList<int>();

      expect(() => twoPartList[0], throwsRangeError);
      expect(() => twoPartList[1], throwsRangeError);
    });

    test('should be unmodifiable', () {
      const twoPartList = TwoPartList<int>(top: [1, 2, 3], bottom: [4, 5, 6]);

      expect(() => twoPartList.add(7), throwsUnsupportedError);
      expect(() => twoPartList.insert(0, 0), throwsUnsupportedError);
      expect(() => twoPartList.remove(1), throwsUnsupportedError);
      expect(() => twoPartList.clear(), throwsUnsupportedError);
    });

    test('should provide unmodifiable views of top and bottom lists', () {
      final topList = [1, 2, 3];
      final bottomList = [4, 5, 6];
      final twoPartList = TwoPartList<int>(top: topList, bottom: bottomList);

      expect(twoPartList.top, orderedEquals(topList));
      expect(twoPartList.bottom, orderedEquals(bottomList));

      expect(() => twoPartList.top.add(7), throwsUnsupportedError);
      expect(() => twoPartList.bottom.remove(4), throwsUnsupportedError);
    });

    test('should iterate over elements in the correct order', () {
      final topList = [1, 2, 3];
      final bottomList = [4, 5, 6];
      final twoPartList = TwoPartList<int>(top: topList, bottom: bottomList);

      expect(twoPartList.toList(), orderedEquals([...topList, ...bottomList]));
    });

    test('should handle empty top and bottom lists', () {
      const twoPartList = TwoPartList<int>();

      expect(twoPartList.length, equals(0));
      expect(twoPartList.isEmpty, isTrue);
      expect(twoPartList.isNotEmpty, isFalse);
      expect(twoPartList, isEmpty);
    });

    test('should handle a single empty list', () {
      final emptyList = <int>[];
      final twoPartList = TwoPartList<int>(top: emptyList, bottom: emptyList);

      expect(twoPartList.length, equals(0));
      expect(twoPartList.isEmpty, isTrue);
      expect(twoPartList.isNotEmpty, isFalse);
      expect(twoPartList, isEmpty);
    });

    test('should handle large lists', () {
      final topList = List<int>.generate(10000, (index) => index);
      final bottomList = List<int>.generate(5000, (index) => index);
      final twoPartList = TwoPartList<int>(top: topList, bottom: bottomList);

      expect(twoPartList.length, equals(15000));

      for (var i = 0; i < 10000; i++) {
        expect(twoPartList[i], equals(i));
      }

      for (var i = 10000; i < 15000; i++) {
        expect(twoPartList[i], equals(i - 10000));
      }
    });
  });
}
