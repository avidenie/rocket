import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/models/listing_dto.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('fromJson()', () {
    late Map<String, dynamic> source;

    setUp(() {
      source = json.decode(fixture('listing.json'));
    });

    test('creates a new listing when the JSON is a valid Listing object', () {
      // act
      fromJson(Object? child) => child as String;
      final listing = ListingDto.fromJson(source, fromJson);

      // assert
      expect(
        listing,
        isA<ListingDto>()
            .having((post) => post.children, 'children', hasLength(2))
            .having((post) => post.children[0], 'first child',
                'Lorem qui reprehenderit voluptate.'),
      );
    });

    test('throws type error when children is missing from JSON source', () {
      // arrange
      fromJson(Object? child) => child as String;

      // act and assert
      expect(
        () => ListingDto.fromJson(<String, dynamic>{'key': 'value'}, fromJson),
        throwsA(
          isA<TypeError>().having((err) => err.toString(), 'toString()',
              'type \'Null\' is not a subtype of type \'List<dynamic>\' in type cast'),
        ),
      );
    });

    test('throws type error when children is not a List in JSON source', () {
      // arrange
      fromJson(Object? child) => child as String;

      // act and assert
      expect(
        () => ListingDto.fromJson(
            <String, dynamic>{'children': 'value'}, fromJson),
        throwsA(
          isA<TypeError>().having((err) => err.toString(), 'toString()',
              'type \'String\' is not a subtype of type \'List<dynamic>\' in type cast'),
        ),
      );
    });
  });
}
