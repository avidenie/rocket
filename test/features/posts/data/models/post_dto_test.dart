import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/models/post_dto.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('fromJson()', () {
    late Map<String, dynamic> source;

    setUp(() {
      source = 'post.json'.toFixture();
    });

    test('creates a new post when the JSON is a valid Post object', () {
      // act
      final post = PostDto.fromJson(source);

      // assert
      expect(
        post,
        isA<PostDto>()
            .having((post) => post.id, 'id', '1000a')
            .having((post) => post.title, 'title', 'lorem ipsum')
            .having((post) => post.author, 'author', 'John Doe')
            .having((post) => post.subreddit, 'subreddit', 'news')
            .having((post) => post.created, 'created', 1684591224)
            .having((post) => post.numComments, 'numComments', 15465)
            .having((post) => post.score, 'score', 2305)
            .having((post) => post.hideScore, 'hideScore', false),
      );
    });

    void testMissingKey(String key) {
      test('throws type error when the $key is missing from JSON source', () {
        // arrange
        source.remove(key);

        // act
        call() => PostDto.fromJson(source);

        // assert
        expect(
          call,
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

        // act
        call() => PostDto.fromJson(source);

        // assert
        expect(
            call,
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
