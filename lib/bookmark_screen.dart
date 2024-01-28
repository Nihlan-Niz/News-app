import 'package:flutter/material.dart';
import 'article_widget.dart'; // Import the ArticleWidget

class BookmarkScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookmarkedArticles;

  BookmarkScreen(this.bookmarkedArticles);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Articles'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
            article: bookmarkedArticles[index],
            onBookmark: (article) {
              // You can implement unbookmark logic here if needed
            },
          );
        },
      ),
      backgroundColor: Color.fromARGB(255, 82, 235, 110),
    );
  }
}
