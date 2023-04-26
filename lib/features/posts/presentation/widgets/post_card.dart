import 'package:flutter/material.dart';

import '../../domain/models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            leading: const CircleAvatar(),
            title: Text(post.author),
            subtitle: Text(post.community),
          ),
          SafeArea(
            minimum: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            top: false,
            bottom: false,
            child: Text(
              post.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(height: 1.4),
            ),
          )
        ],
      ),
    );
  }
}
