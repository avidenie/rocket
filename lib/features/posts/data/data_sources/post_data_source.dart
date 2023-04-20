import '../models/post_dto.dart';

abstract class PostDataSource {
  Future<List<PostDto>> getPopularPosts();
}
