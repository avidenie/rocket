import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/mappers/post_to_domain.dart';
import 'package:rocket/features/posts/domain/models/post.dart';

import '../../../../fixtures/post_dtos.dart';

void main() {
  group('toDomain()', () {
    test('returns a Post', () {
      // arrange
      const postDto = tPostDto1;

      // act
      final post = postDto.toDomain();

      // assert
      expect(
        post,
        Post.text(
          data: PostData(
            id: postDto.id,
            title: postDto.title,
            author: Author(name: postDto.author),
            community: postDto.subreddit,
            created: DateTime.fromMillisecondsSinceEpoch(
                (postDto.created * 1000).toInt()),
            score: Score(value: postDto.score, hidden: postDto.hideScore),
            comments: postDto.numComments,
          ),
        ),
      );
    });
  });
}
