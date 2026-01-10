import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => PostModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<PostModel> createPost(PostModel post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menambah data');
    }
  }

  Future<void> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data');
    }
  }
}
