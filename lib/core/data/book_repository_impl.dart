import 'dart:convert';

import 'package:book/core/models/book.dart';
import 'package:book/core/repositories/book_repository.dart';
import 'package:http/http.dart' as http;

class BookRepositoryImpl implements BookRepository {
  @override
  Future<List<Book>> searchBooks(String searchQuery) async {
    final url = Uri.parse('https://openlibrary.org/search.json?q={query}');
    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final List booksData = data['docs'];
      return booksData.map((json) => Book.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to fetch the data');
    }

  }

}