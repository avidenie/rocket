import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/popular_posts_controller.dart';
import '../widgets/post_card.dart';

class PopularPostsScreen extends StatelessWidget {
  const PopularPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final controller = ref.watch(popularPostsControllerProvider);

          return controller.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('error: $err'),
            data: (popularPosts) {
              return ListView.separated(
                itemBuilder: (context, index) =>
                    PostCard(post: popularPosts[index]),
                itemCount: popularPosts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              );
            },
          );
        },
      ),
    );
  }
}
