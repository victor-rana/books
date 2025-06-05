import 'dart:core';

class Book {
  String? title;
  List<String>? authorName;
  int? firstPublishYear;

  Book({this.title, this.authorName, this.firstPublishYear});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    authorName = json['author_name'].cast<String>();
    firstPublishYear = json['first_publish_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['author_name'] = this.authorName;
    data['first_publish_year'] = this.firstPublishYear;
    return data;
  }
}