import '../../domain/models/post.dart';
import '../models/post_dto.dart';

extension PostToDomain on PostDto {
  Post toDomain() {
    final postData = PostData(
      id: id,
      title: title,
      body: selftext != null && selftext!.isNotEmpty ? selftext! : null,
      community: subreddit,
      author: Author(name: author),
      created: DateTime.fromMillisecondsSinceEpoch((created * 1000).toInt()),
      score: Score(value: score, hidden: hideScore),
      comments: numComments,
    );

    return Post.text(data: postData);
  }
}
