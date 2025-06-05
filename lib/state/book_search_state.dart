import 'package:book/core/models/book.dart';

class BookSearchState{
  final List<Book> books;
  final bool isLoading;
  final String error;

  BookSearchState({
    this.books = const [],
    this.isLoading = false,
    this.error = ''
});

  BookSearchState copyWith({
     List<Book>? books,
     required bool isLoading,
     String? error,
}){
    return BookSearchState(
      books: this.books,
      isLoading: this.isLoading,
      error: this.error
    );
  }
}