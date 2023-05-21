import 'package:rocket/features/posts/data/models/post_dto.dart';

const tPostDto1 = PostDto(
  id: '1000a',
  title: 'lorem ipsum 1',
  author: 'author 1',
  subreddit: 'news',
  created: 1684579078,
  numComments: 13278,
  score: 3257,
  hideScore: false,
);
const tPostDto2 = PostDto(
  id: '2000b',
  title: 'lorem ipsum 2',
  author: 'author 2',
  subreddit: 'news',
  created: 1684591224,
  numComments: 2578,
  score: 14598,
  hideScore: true,
);

final tPostDtos = [tPostDto1, tPostDto2];
