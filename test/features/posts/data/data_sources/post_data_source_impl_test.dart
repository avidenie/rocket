import 'dart:convert';

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
            json.decode(fixture('posts.json')),
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
                    title: 'Nostrud incididunt magna nisi aute ex.',
                    subreddit: 'news',
                    author: 'Delia Monahan',
                  ),
                )
                .having(
                  (posts) => posts[2],
                  'first child',
                  const PostDto(
                    title: 'Nisi sint eu aliqua nisi irure.',
                    subreddit: 'news',
                    author: 'Gilbert VonRueden',
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

        // act and assert
        expectLater(
          () async => await postDataSource.getPopularPosts(),
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

        Map<String, dynamic> source = json.decode(fixture('posts.json'));
        source['data']['children'][0]['data']['title'] = 0;

        dioAdapter.onGet(
          '/r/popular.json',
          (server) => server.reply(
            200,
            source,
          ),
        );

        // act and assert
        expectLater(
          () async => await postDataSource.getPopularPosts(),
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

        // act and assert
        expectLater(
          () async => await postDataSource.getPopularPosts(),
          throwsA(
            isA<DioError>().having((err) => err.message, 'message',
                'The request returned an invalid status code of 500.'),
          ),
        );
      },
    );
  });
}
