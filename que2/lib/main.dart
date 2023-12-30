import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    List<dynamic> data=jsonDecode(response.body);
    List<Album> albums =data.map((json) =>Album.fromJson(json)).toList();
 
  return albums;
  } 
  else {
    throw Exception('Failed to load album');
  }
}

Future<http.Response> createAlbum(String title) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );
}

Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson((response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to delete album.');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;
  final TextEditingController title=TextEditingController();
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              
            SizedBox(width:20,child: TextField(controller: title)),
            IconButton(onPressed: ()=>{
                createAlbum(title.text.toString())
              }, icon: Icon(Icons.add),),
            ],
          ),
        ),
        ),
        appBar: AppBar(
          title: const Text('Album Data'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
    Album album = snapshot.data![index];
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ListTile(
        contentPadding: EdgeInsets.all(6),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromARGB(255, 44, 176, 188), width: 1.4),
          borderRadius: BorderRadius.circular(8), 
        ),
        title: Text(album.title),
        subtitle: Text('ID: ${album.id}'),
        tileColor: Color.fromARGB(0, 82, 182, 182),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () { 
            deleteAlbum(album.id.toString());
          },
        ),
      ),
    );
  },
);

                } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}