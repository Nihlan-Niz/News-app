import 'package:flutter/material.dart';
import 'category_view.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> articles;

  CategoryScreen({required this.articles});

  final List<String> categories = [
    'Business',
    'Technology',
    'Science',
    'Health',
    'Entertainment',
    'Sports',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color.fromARGB(255, 0, 0, 0),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text(categories[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryView(selectedCategory: categories[index],
                      articles: articles
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      backgroundColor: Color.fromARGB(255, 82, 235, 110),
    );
  }
}
