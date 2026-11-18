import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


final postProvider = FutureProvider<List<PostModel>>((ref) async {

  try {

    final response = await http
    .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
    .timeout(const Duration(seconds: 2));
    
    
    if (response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      List<PostModel> postList = data.map((item) => PostModel.fromJson(item)).toList();
      return postList;
    }else{
      throw ('some thing went wrong');
    }

  }  on SocketException {
    throw ('No Internet connection');
  } catch (e) {
    rethrow;
  }
    
});

class PostModel{
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({required this.id, required this.userId, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json){
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body']
    );
  }
}
