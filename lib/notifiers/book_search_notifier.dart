
import 'dart:async';

import 'package:book/core/repositories/book_repository.dart';
import 'package:book/state/book_search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookSearchNotifier extends StateNotifier<BookSearchState> {

  final BookRepository repository;
  Timer? _debounce;

  BookSearchNotifier(this.repository): super (BookSearchState());


  void search(String query){
    if(query.isEmpty) return;
    _debounce = Timer(Duration(milliseconds: 1000), () async {

      state = state.copyWith(isLoading: true);
      try{
        final books = await repository.searchBooks(query);
        if(books.isEmpty){
          state = state.copyWith(books: books, isLoading: false, error: 'No Data Found');
        }
        else{
          state = state.copyWith(books: books, isLoading: false);
        }
      }
      catch(ex) {
        state = state.copyWith(isLoading: false, error: ex.toString());
      }
    }
      );
  }
}