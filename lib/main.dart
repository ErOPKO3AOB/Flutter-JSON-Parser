import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_parser/data/repositories/post_repository.dart';
import 'package:json_parser/features/posts/view/posts_page.dart';

void main() {
  final postRepository = PostRepository(Dio(
  BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    sendTimeout: Duration(seconds: 3),
    connectTimeout: Duration(seconds: 15),
    headers: {
      'User-Agent': 'PostmanRuntime/7.29.2', // Прикидываемся известным софтом
      'Accept': '*/*',
      },
    ),
  ));
    
  runApp(RepositoryProvider(
    create: (context) => postRepository,
    child: const PostsPage()));
}