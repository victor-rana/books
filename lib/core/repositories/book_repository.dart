import 'package:book/core/models/book.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String searchQuery);
}