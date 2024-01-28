import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  final String selectedCategory;
  final List<Map<String, dynamic>> articles;

  CategoryView({required this.selectedCategory, required this.articles});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> newsForCategory = getNewsForCategory();

    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedCategory News'),
      ),
      body: ListView.builder(
        itemCount: newsForCategory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newsForCategory[index]['title'] ?? ''),
            subtitle: Text(newsForCategory[index]['description']?.toString() ?? ''),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> getNewsForCategory() {
    return articles.where((article) {
      final categories = article['category'] as List<String>? ?? [];
      return categories.contains(selectedCategory);
    }).toList();
  }
}
