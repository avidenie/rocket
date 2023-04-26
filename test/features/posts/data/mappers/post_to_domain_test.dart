import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/mappers/post_to_domain.dart';
import 'package:rocket/features/posts/data/models/post_dto.dart';
import 'package:rocket/features/posts/domain/models/post.dart';

void main() {
  group('toDomain()', () {
    test('returns a Post', () {
      // arrange
      const postDto = PostDto(
        title: 'Laborum sunt consequat cupidatat duis.',
        subreddit: 'news',
        author: 'Santos Altenwerth',
      );

      // act
      final post = postDto.toDomain();

      // assert
      expect(
        post,
        const Post(
          title: 'Laborum sunt consequat cupidatat duis.',
          community: 'news',
          author: 'Santos Altenwerth',
        ),
      );
    });
  });
}
