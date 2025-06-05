import 'package:book/core/data/book_repository_impl.dart';
import 'package:book/core/repositories/book_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/book_search_notifier.dart';
import '../state/book_search_state.dart';

final bookRepositoryProvider = Provider<BookRepository>(
  (ref) => BookRepositoryImpl(),
);

final bookSeacrhProvider =
    StateNotifierProvider<BookSearchNotifier, BookSearchState>((ref) {
      final repo = ref.read(bookRepositoryProvider);
      return BookSearchNotifier(repo);
    });

class BookSearchScreen extends ConsumerWidget {
  const BookSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookSeacrhProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Search'),
              onChanged: (query) {
                ref.read(bookSeacrhProvider.notifier).search(query);
              },
            ),
            if (state.isLoading)
              const CircularProgressIndicator()
            else if (state.error != null)
              Text(state.error)
            else
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return ListTile(
                      title: Text(book.title!),
                      subtitle: Text(
                        '${book.authorName?[0]} \n first published ${book.firstPublishYear}',
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
