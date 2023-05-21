import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rocket/features/posts/data/repositories/post_repository_impl.dart';
import 'package:rocket/features/posts/domain/models/post.dart';
import 'package:rocket/features/posts/domain/repositories/post_repository.dart';
import 'package:rocket/features/posts/presentation/controllers/popular_posts_controller.dart';

import '../../../../fixtures/posts.dart';
import 'popular_posts_controller_test.mocks.dart';

class Listener<T> extends Mock {
  void call(T? previous, T? next);
}

@GenerateNiceMocks([MockSpec<PostRepository>()])
void main() {
  // A helper method to create a ProviderContainer that overrides the post
  // repository provider.
  ProviderContainer setupContainer(MockPostRepository postRepository) {
    final container = ProviderContainer(
      overrides: [
        postRepositoryProvider.overrideWithValue(postRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('initial state is AsyncLoading', () {
    // arrange
    final postRepository = MockPostRepository();
    final container = setupContainer(postRepository);
    final listener = Listener<AsyncValue<List<Post>>>();

    // act
    container.listen(
      popularPostsControllerProvider,
      listener,
      fireImmediately: true,
    );

    // assert
    verify(listener(null, const AsyncLoading<List<Post>>()));
    verifyNoMoreInteractions(listener);
  });

  test('state is AsyncData when loading a list of popular posts', () async {
    // ARRANGE

    // create a mock repository
    final postRepository = MockPostRepository();

    // create the ProviderContainer with the mock repository
    final container = setupContainer(postRepository);

    // stub the repository response
    when(postRepository.getPopularPosts())
        .thenAnswer((_) => Future.value(tPosts));

    // create a listener
    final listener = Listener<AsyncValue<List<Post>>>();

    // listen to the provider and call listener whenever its value changes
    container.listen(
      popularPostsControllerProvider,
      listener,
      fireImmediately: true,
    );

    // ACT
    var popularPosts =
        await container.read(popularPostsControllerProvider.future);

    // ASSERT
    verifyInOrder([
      listener(null, const AsyncLoading<List<Post>>()),
      listener(const AsyncLoading<List<Post>>(), AsyncData<List<Post>>(tPosts)),
    ]);

    verify(postRepository.getPopularPosts()).called(1);
    verifyNoMoreInteractions(listener);

    expect(popularPosts, tPosts);
  });

  test(
      'state is AsyncError when an error occurs '
      'while loading the list of popular posts', () async {
    // ARRANGE
    // create a mock repository
    final postRepository = MockPostRepository();

    // create the ProviderContainer with the mock repository
    final container = setupContainer(postRepository);

    // create an exception
    final exception = Exception('Some error message');

    // stub the repository response
    when(postRepository.getPopularPosts()).thenThrow(exception);

    // create a listener
    final listener = Listener<AsyncValue<List<Post>>>();

    // listen to the provider and call listener whenever its value changes
    container.listen(
      popularPostsControllerProvider,
      listener,
      fireImmediately: true,
    );

    // ACT
    final call = container.read(popularPostsControllerProvider.future);

    // ASSERT
    await expectLater(call, throwsA(isA<Exception>()));

    verifyInOrder([
      listener(null, const AsyncLoading<List<Post>>()),
      listener(const AsyncLoading<List<Post>>(), argThat(isA<AsyncError>())),
    ]);

    verify(postRepository.getPopularPosts()).called(1);
    verifyNoMoreInteractions(listener);
  });
}
