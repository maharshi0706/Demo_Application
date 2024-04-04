// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      if (!mounted) return;
      setState(() {
        events = data.map((json) => Event.fromJson(json)).toList();
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(
                    event.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Text(event.body),
                  // trailing: SizedBox(
                  //   // height: 40,
                  //   // width: 40,
                  //   child: Image.network(
                  //     event.imageURL,
                  //     height: 80,
                  //     width: 40,
                  //   ),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border_outlined),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.comment),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}

class Event {
  final String title;
  final String body;
  final String id;
  final String imageURL;

  Event({
    required this.title,
    required this.body,
    required this.id,
    required this.imageURL,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      body: json['eventDescription'] as String,
      id: json['_id'] as String,
      imageURL: (json['image'] as List<dynamic>).isEmpty
          ? ''
          : json['image'][0] as String,
    );
  }
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
// class Post {
//   final String title;
//   final String body;
//   final int id;

//   Post({required this.body, required this.id, required this.title});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(id: json['id'], title: json['title'], body: json['body']);
//   }
// }
