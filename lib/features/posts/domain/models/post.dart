import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
sealed class Post with _$Post {
  const factory Post.text({
    required PostData data,
  }) = TextPost;

  const factory Post.link({
    required PostData data,
  }) = LinkPost;

  const factory Post.image({
    required PostData data,
  }) = ImagePost;

  const factory Post.gif({
    required PostData data,
  }) = GifPost;

  const factory Post.video({
    required PostData data,
  }) = VideoPost;

  const factory Post.gallery({
    required PostData data,
  }) = GalleryPost;
}

@freezed
sealed class PostData with _$PostData {
  const factory PostData({
    required String id,
    required String title,
    String? body,
    required Author author,
    required String community,
    required DateTime created,
    required Score score,
    required int comments,
  }) = _PostData;
}

@freezed
sealed class Author with _$Author {
  const factory Author({
    required String name,
  }) = _Author;
}

@freezed
sealed class Score with _$Score {
  const factory Score({
    required int value,
    required bool hidden,
  }) = _Score;
}
