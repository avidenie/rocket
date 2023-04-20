import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/models/post_dto.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('fromJson()', () {
    late Map<String, dynamic> source;

    setUp(() {
      source = json.decode(fixture('post.json'));
    });

    test('creates a new post when the JSON is a valid Post object', () {
      // act
      final post = PostDto.fromJson(source);

      // assert
      expect(
        post,
        isA<PostDto>()
            .having((post) => post.title, 'title', 'lorem ipsum')
            .having((post) => post.author, 'author', 'John Doe')
            .having((post) => post.subreddit, 'subreddit', 'news'),
      );
    });

    void testMissingKey(String key) {
      test('throws type error when the $key is missing from JSON source', () {
        // arrange
        source.remove(key);

        // act and assert
        expect(
          () => PostDto.fromJson(source),
          throwsA(
            isA<TypeError>().having((err) => err.toString(), 'toString()',
                startsWith('type \'Null\' is not a subtype of type')),
          ),
        );
      });
    }

    final requiredKeys = ['title', 'subreddit', 'author'];
    for (final key in requiredKeys) {
      testMissingKey(key);
    }

    void testInvalidKey<T>(String key, T value) {
      test('throws type error when the $key is invalid in the JSON source', () {
        // arrange
        source[key] = value;

        // act and assert
        expect(
            () => PostDto.fromJson(source),
            throwsA(isA<TypeError>().having(
                (err) => err.toString(),
                'toString()',
                startsWith('type \'$T\' is not a subtype of type'))));
      });
    }

    final invalidKeys = {'title': 0, 'subreddit': 0, 'author': 0};
    for (final key in requiredKeys) {
      testInvalidKey(key, invalidKeys[key]!);
    }
  });
}
