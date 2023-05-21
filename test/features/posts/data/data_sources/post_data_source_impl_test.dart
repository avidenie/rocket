import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rocket/features/posts/data/data_sources/post_data_source_impl.dart';
import 'package:rocket/features/posts/data/models/post_dto.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('getPopularPosts()', () {
    test(
      'returns a list of popular posts',
      () async {
        // arrange
        final dio = Dio();
        final dioAdapter = DioAdapter(dio: dio);
        final postDataSource = PostDataSourceImpl(dio: dio);

        dioAdapter.onGet(
          '/r/popular.json',
          (server) => server.reply(
            200,
            'posts.json'.toFixture(),
          ),
        );

        // act
        final posts = await postDataSource.getPopularPosts();

        // assert
        expect(
          posts,
          allOf(
            isA<List<PostDto>>()
                .having(
                  (posts) => posts[0],
                  'first child',
                  const PostDto(
                    id: '12ab345',
                    title: 'Nostrud incididunt magna nisi aute ex.',
                    subreddit: 'news',
                    author: 'Delia Monahan',
                    created: 1684578940,
                    numComments: 5192,
                    score: 26139,
                    hideScore: false,
                  ),
                )
                .having(
                  (posts) => posts[2],
                  'first child',
                  const PostDto(
                    id: '12bc456',
                    title: 'Nisi sint eu aliqua nisi irure.',
                    subreddit: 'news',
                    author: 'Gilbert VonRueden',
                    created: 1684591224,
                    numComments: 782,
                    score: 627,
                    hideScore: true,
                  ),
                ),
            hasLength(3),
          ),
        );
      },
    );

    test(
      'throws error when the response JSON is missing listing data',
      () async {
        // arrange
        final dio = Dio();
        final dioAdapter = DioAdapter(dio: dio);
        final postDataSource = PostDataSourceImpl(dio: dio);

        dioAdapter.onGet(
          '/r/popular.json',
          (server) => server.reply(
            200,
            <String, dynamic>{'key': 'value'},
          ),
        );

        // act
        final call = postDataSource.getPopularPosts;

        // assert
        expectLater(
          call,
          throwsA(
            isA<TypeError>().having((err) => err.toString(), 'toString()',
                'type \'Null\' is not a subtype of type \'Map<String, dynamic>\''),
          ),
        );
      },
    );

    test(
      'throws error when the response JSON cannot be parsed as list of posts',
      () async {
        // arrange
        final dio = Dio();
        final dioAdapter = DioAdapter(dio: dio);
        final postDataSource = PostDataSourceImpl(dio: dio);

        final source = 'posts.json'.toFixture();
        source['data']['children'][0]['data']['title'] = 0;

        dioAdapter.onGet(
          '/r/popular.json',
          (server) => server.reply(
            200,
            source,
          ),
        );

        // act
        final call = postDataSource.getPopularPosts;

        // assert
        expectLater(
          call,
          throwsA(
            isA<TypeError>().having((err) => err.toString(), 'toString()',
                'type \'int\' is not a subtype of type \'String\' in type cast'),
          ),
        );
      },
    );

    test(
      'throws error when the HTTP request fail',
      () async {
        // arrange
        final dio = Dio();
        final dioAdapter = DioAdapter(dio: dio);
        final postDataSource = PostDataSourceImpl(dio: dio);

        dioAdapter.onGet(
          '/r/popular.json',
          (server) => server.reply(500, null),
        );

        // act
        final call = postDataSource.getPopularPosts;

        // assert
        expectLater(
          call,
          throwsA(
            isA<DioError>().having((err) => err.message, 'message',
                'The request returned an invalid status code of 500.'),
          ),
        );
      },
    );
  });
}
