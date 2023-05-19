import 'package:flutter/material.dart';

import '../../domain/models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _Content(post: post),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Heading(post: post),
        _Title(post: post),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Text(
        post.title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.4),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const CircleAvatar(),
      title: Text(post.author),
      subtitle: Text(post.community),
    );
  }
}
