import 'package:flutter/material.dart';

import '../../../../core/presentation/custom_icons.dart';
import '../../../../utils/numbers.dart';
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
        if (post.data.body != null) _Body(post: post),
        _Actions(post: post),
      ],
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
      title: Text(post.data.author.name),
      subtitle: Text(post.data.community),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        post.data.title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.4),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Text(
        post.data.body!.trim().replaceAll('\n', ''),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        _UpVoteButton(post: post),
        _Score(post: post),
        _DownVoteButton(post: post),
        const Spacer(),
        _CommentsButton(post: post),
        const Spacer(),
        _ShareButton(post: post),
        const SizedBox(width: 8)
      ],
    );
  }
}

class _UpVoteButton extends StatelessWidget {
  const _UpVoteButton({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      onPressed: () {},
      icon: const Icon(CustomIcons.up_vote),
      selectedIcon: const Icon(CustomIcons.up_vote_solid),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _DownVoteButton extends StatelessWidget {
  const _DownVoteButton({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      onPressed: () {},
      icon: const Icon(CustomIcons.down_vote),
      selectedIcon: const Icon(CustomIcons.down_vote_solid),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Text(
      post.data.score.hidden ? 'Vote' : roundNumber(post.data.score.value),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class _CommentsButton extends StatelessWidget {
  const _CommentsButton({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.chat_bubble_outline, size: 20),
      label: Text(
        roundNumber(post.data.comments),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      style: TextButton.styleFrom(
        disabledForegroundColor: Theme.of(context).textTheme.bodySmall?.color,
        foregroundColor: Theme.of(context).textTheme.bodySmall?.color,
      ),
      onPressed: () {},
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.share, size: 20),
      label: Text('Share', style: Theme.of(context).textTheme.bodySmall),
      style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).textTheme.bodySmall?.color),
      onPressed: () {},
    );
  }
}
