import '../../domain/models/post.dart';
import '../models/post_dto.dart';

extension PostToDomain on PostDto {
  Post toDomain() {
    return Post(
      title: title,
      author: author,
      community: subreddit,
    );
  }
}
