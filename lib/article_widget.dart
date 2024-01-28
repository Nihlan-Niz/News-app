import 'package:flutter/material.dart';

class ArticleWidget extends StatefulWidget {
  final Map<String, dynamic> article;
  final Function(Map<String, dynamic>) onBookmark;

  ArticleWidget({required this.article, required this.onBookmark});

  @override
  _ArticleWidgetState createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(widget.article['title'] ?? ''),
        subtitle: Text(widget.article['description'] ?? ''),
        trailing: IconButton(
          icon: isBookmarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
          onPressed: () {
            setState(() {
              isBookmarked = !isBookmarked;
            });
            widget.onBookmark(widget.article);
          },
        ),
      ),
    );
  }
}
