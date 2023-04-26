import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_data_source.dart';
import '../data_sources/post_data_source_impl.dart';
import '../mappers/post_to_domain.dart';

part 'post_repository_impl.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
PostRepository postRepository(PostRepositoryRef ref) =>
    PostRepositoryImpl(dataSource: PostDataSourceImpl());

class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl({required this.dataSource});

  final PostDataSource dataSource;

  @override
  Future<List<Post>> getPopularPosts() async {
    final posts = await dataSource.getPopularPosts();
    return posts.map((post) => post.toDomain()).toList(growable: false);
  }
}
