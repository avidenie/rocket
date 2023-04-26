import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/post_repository_impl.dart';
import '../../domain/models/post.dart';

part 'popular_posts_controller.g.dart';

@Riverpod(dependencies: [postRepository])
Future<List<Post>> popularPostsController(PopularPostsControllerRef ref) async {
  return ref.watch(postRepositoryProvider).getPopularPosts();
}
