import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // List<Post> posts = [];
  List<Event> events = [];
  int currentPage = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchEvents();

    // fetchPosts();
    scrollController.addListener(scrollListener);
  }

  Future<void> fetchEvents() async {
    final response = await http
        .get(Uri.parse("https://post-api-omega.vercel.app/api/posts?page=1"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // print(data);
      setState(() {
        events = data.map((json) => Event.fromJson(json)).toList();
        print(events[0]);
      });
    } else {
      throw Exception('Failed to load events.');
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // void fetchPosts() async {
  //   final response = await http.get(Uri.parse(
  //       'https://post-api-omega.vercel.app/api/posts?page=$currentPage'));

  //   if (response.statusCode == 200) {
  //     List<Post> newPosts = (json.decode(response.body) as List)
  //         .map((e) => Post.fromJson(e))
  //         .toList();

  //     setState(() {
  //       posts.addAll(newPosts);
  //     });
  //   } else {
  //     throw Exception('Failed to load posts.');
  //   }
  // }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        currentPage++;
      });
      fetchEvents();
      // fetchPosts();
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     controller: scrollController,
  //     itemCount: posts.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(posts[index].title),
  //         subtitle: Text(posts[index].body),
  //         onTap: () {},
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(title: Text(event.title), subtitle: Text(event.body));
      },
    );
  }
}

// class Post {
//   final String title;
//   final String body;
//   final int id;

//   Post({required this.body, required this.id, required this.title});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(id: json['id'], title: json['title'], body: json['body']);
//   }
// }

class Event {
  final String title;
  final String body;
  final int id;
  final String imageURL;

  Event(
      {required this.body,
      required this.id,
      required this.imageURL,
      required this.title});

  factory Event.fromJson(Map<String, dynamic> json) {
    print("HI");
    print(json['eventDescription']);
    return Event(
      id: json["_id"],
      body: json["eventDescription"],
      title: json["title"],
      imageURL: json["image"],
    );
  }
}
