import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List<Post> posts = [];
  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetchPosts() async {
    final response = await http.get(Uri.parse(
        'https://post-api-omega.vercel.app/api/posts?page=$currentPage'));

    if (response.statusCode == 200) {
      List<Post> newPosts = (json.decode(response.body) as List)
          .map((e) => Post.fromJson(e))
          .toList();

      setState(() {
        posts.addAll(newPosts);
      });
    } else {
      throw Exception('Failed to load posts.');
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        currentPage++;
      });
      fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(posts[index].title),
          subtitle: Text(posts[index].body),
          onTap: () {},
        );
      },
    );
  }
}

class Post {
  final String title;
  final String body;
  final int id;

  Post({required this.body, required this.id, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }
}
