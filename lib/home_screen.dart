import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'article_widget.dart';
import 'bookmark_screen.dart';
import 'category_screen.dart';
import 'search_screen.dart';

const apiKey = '2c9460bd69564d2aac2fe4ed0f4dd6b3';
const apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> articles = [];
  bool isAscending = true; // Variable to track sorting order
  String selectedSortOption = 'A to Z'; 
  

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        articles = (jsonDecode(response.body)['articles'] as List)
              .cast<Map<String, dynamic>>();
        });
    } else {
      throw Exception('Failed to load news');
    }
  }

  List<Map<String, dynamic>> bookmarkedArticles = [];

  @override
  Widget build(BuildContext context) {

    articles.sort((a, b) {
      if (isAscending) {
        return a['title'].compareTo(b['title']);
      } else {
        return b['title'].compareTo(a['title']);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        // Category Icon
          leading: IconButton(
            icon: Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen(articles: articles)),
              );
            },
          ),
        actions: [
          // Search Icon
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(articles: articles),
                ),
              );
            },
          ),
          //  Sort Icon 
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              // Toggle the sorting order when the sort icon is pressed
              setState(() {
                //isAscending = !isAscending;
                _showSortOptions(context);
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
            article: articles[index],
            onBookmark: (article) {
              handleBookmark(article);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookmarkScreen(bookmarkedArticles),
            ),
          );
        },
        child: Icon(Icons.bookmark),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: Color.fromARGB(255, 82, 235, 110),
    );
  }

  void handleBookmark(Map<String, dynamic> article) {
    setState(() {
      if (bookmarkedArticles.contains(article)) {
        bookmarkedArticles.remove(article);
      } else {
        bookmarkedArticles.add(article);
      }
    });
  }

  void _showSortOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort Articles'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedSortOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSortOption = newValue!;
                    _sortArticles();
                    Navigator.pop(context); // Close the dialog
                  });
                },
                items: ['A to Z'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sortArticles() {
    setState(() {
      if (selectedSortOption == 'A to Z') {
        articles.sort((a, b) => a['title'].compareTo(b['title']));
      } else {
        articles.sort((a, b) => b['title'].compareTo(a['title']));
      }
    });
  }
}  

