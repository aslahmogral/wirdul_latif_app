import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/blog_screen_model.dart';
import 'package:wirdul_latif/screens/blog_screen.dart/webview.dart';
import 'package:wirdul_latif/utils/responsive.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlogScreenModel(),
      child: Consumer<BlogScreenModel>(
        builder: (context, model, child) {
          dynamic blogs = WirdulLatif.blogs;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Blogs'),
              centerTitle: true,
            ),
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.isTablet ? 1000 : double.infinity,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: context.isTablet
                      ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4.5,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: blogs.length,
                          itemBuilder: (context, index) {
                            return _buildBlogCard(context, blogs[index]);
                          },
                        )
                      : ListView.builder(
                          itemCount: blogs.length,
                          itemBuilder: (context, index) {
                            return _buildBlogCard(context, blogs[index]);
                          },
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, dynamic blog) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: blog['url'],
                      title: blog['title'],
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Center(
          child: ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.teal),
            title: Text(
              blog['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ),
    );
  }
}
