import 'package:dio/dio.dart';
import 'package:json_parser/data/models/post.dart';

class PostRepository {
  final Dio _dio;

  const PostRepository(this._dio);

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await _dio.get("/posts");
      final List<dynamic> data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
