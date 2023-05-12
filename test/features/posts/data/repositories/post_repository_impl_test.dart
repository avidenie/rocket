import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/data_sources/post_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rocket/features/posts/data/mappers/post_to_domain.dart';
import 'package:rocket/features/posts/data/models/post_dto.dart';
import 'package:rocket/features/posts/data/repositories/post_repository_impl.dart';

import 'post_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostDataSource>()])
void main() {
  late PostRepositoryImpl repository;
  late MockPostDataSource mockPostDataSource;

  setUp(() {
    mockPostDataSource = MockPostDataSource();
    repository = PostRepositoryImpl(dataSource: mockPostDataSource);
  });

  group('getPopularPosts()', () {
    test(
      'returns an empty list when the data source returns an empty list',
      () async {
        // arrange
        when(mockPostDataSource.getPopularPosts()).thenAnswer((_) async => []);

        // act
        final result = await repository.getPopularPosts();

        // assert
        verify(mockPostDataSource.getPopularPosts());
        expect(result, equals([]));
      },
    );

    test(
      'returns a list of posts loaded by the data source',
      () async {
        // ARRANGE
        // create a list of posts
        const tPost1 = PostDto(
            title: 'lorem ipsum 1', author: 'author 1', subreddit: 'news');
        const tPost2 = PostDto(
            title: 'lorem ipsum 2', author: 'author 2', subreddit: 'news');
        final tPosts = [tPost1, tPost2];

        // stub the data source response
        when(mockPostDataSource.getPopularPosts())
            .thenAnswer((_) async => Future.value(tPosts));

        // ACT
        final result = await repository.getPopularPosts();

        // ASSERT
        verify(mockPostDataSource.getPopularPosts()).called(1);
        expect(result, tPosts.map((post) => post.toDomain()));
      },
    );

    test(
      'throws an error when the data source throws an error',
      () async {
        // ARRANGE
        // create an exception
        final error = Exception('some error');

        // stub the data source response
        when(mockPostDataSource.getPopularPosts()).thenThrow(error);

        // ACT
        final call = repository.getPopularPosts;

        // ASSERT
        await expectLater(
          call,
          throwsA(
            isA<Exception>().having(
              (err) => err.toString(),
              'toString()',
              'Exception: some error',
            ),
          ),
        );
        verify(mockPostDataSource.getPopularPosts()).called(1);
      },
    );
  });
}
