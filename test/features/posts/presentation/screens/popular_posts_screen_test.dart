import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rocket/features/posts/presentation/controllers/popular_posts_controller.dart';
import 'package:rocket/features/posts/presentation/screens/popular_posts_screen.dart';
import 'package:rocket/features/posts/presentation/widgets/post_card.dart';

import '../../../../fixtures/posts.dart';

void main() {
  group('PopularPostsScreen', () {
    testWidgets('renders a loading indicator', (tester) async {
      // arrange
      final widget = ProviderScope(
        overrides: [
          popularPostsControllerProvider
              .overrideWith((ref) => Future.value(tPosts))
        ],
        child: const MaterialApp(
          home: PopularPostsScreen(),
        ),
      );

      // act
      await tester.pumpWidget(widget);

      // assert
      expect(find.byType(ListView), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders an error message', (tester) async {
      // arrange
      final widget = ProviderScope(
        overrides: [
          popularPostsControllerProvider
              .overrideWith((ref) => throw Exception('some error message'))
        ],
        child: const MaterialApp(
          home: PopularPostsScreen(),
        ),
      );

      // act
      await tester.pumpWidget(widget);

      // assert
      expect(find.byType(ListView), findsNothing);
      expect(find.text('error: Exception: some error message'), findsOneWidget);
    });

    testWidgets('renders an empty list', (tester) async {
      // arrange
      final widget = ProviderScope(
        overrides: [popularPostsControllerProvider.overrideWith((ref) => [])],
        child: const MaterialApp(
          home: PopularPostsScreen(),
        ),
      );

      // act
      await tester.pumpWidget(widget);

      // assert
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);
      expect(
        find.descendant(of: listView, matching: find.byType(PostCard)),
        findsNothing,
      );
    });

    testWidgets('renders a list of posts', (tester) async {
      // arrange
      final widget = ProviderScope(
        overrides: [
          popularPostsControllerProvider.overrideWith((ref) => tPosts)
        ],
        child: const MaterialApp(
          home: PopularPostsScreen(),
        ),
      );

      // act
      await tester.pumpWidget(widget);

      // assert
      expect(tester.widgetList(find.byType(PostCard)), [
        isA<PostCard>().having((s) => s.post, 'first post', tPosts[0]),
        isA<PostCard>().having((s) => s.post, 'second post', tPosts[1]),
      ]);
    });
  });
}
