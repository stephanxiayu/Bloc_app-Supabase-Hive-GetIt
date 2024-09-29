import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_bloc_clean_app/features/blog/presentation/pages/add_new_bloc.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlocPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
    );
  }
}
