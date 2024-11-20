import 'package:flutter/material.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/webview.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic blogs = WirdulLatif.blogs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebView(
                              url: blogs[index]['url'],
                              title: blogs[index]['title'],
                            )));
              },
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_right),
                  title: Text(blogs[index]['title']),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
