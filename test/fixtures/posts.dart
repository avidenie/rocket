import 'package:rocket/features/posts/domain/models/post.dart';

final tPost1 = Post.text(
  data: PostData(
    id: '1000a',
    title: 'Ex incididunt excepteur esse magna duis.',
    author: const Author(name: 'Merle Stroman'),
    community: 'news',
    comments: 0,
    created: DateTime.now(),
    score: const Score(value: 0, hidden: false),
  ),
);

final tPost2 = Post.text(
  data: PostData(
    id: '2000b',
    title: 'Mollit ad incididunt dolor Lorem.',
    author: const Author(name: 'Bridget Becker'),
    community: 'news',
    comments: 0,
    created: DateTime.now(),
    score: const Score(value: 0, hidden: false),
  ),
);

final tPosts = [tPost1, tPost2];
