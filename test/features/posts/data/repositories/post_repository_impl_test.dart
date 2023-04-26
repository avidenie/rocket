import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/data/data_sources/post_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
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
  });
}
