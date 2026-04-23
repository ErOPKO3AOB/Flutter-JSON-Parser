import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_parser/data/repositories/post_repository.dart';
import 'package:json_parser/features/posts/bloc/post_bloc.dart';
import 'package:json_parser/features/posts/bloc/post_event.dart';
import 'package:json_parser/features/posts/bloc/post_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(context.read<PostRepository>())..add(PostRequestEvent()),
      child: MaterialApp(
        home: Scaffold(
        body: PostView(),
        ),
      )
    ); 
  }
}

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return state.when(
          // ЗАГРУЗКА
          loading: () => const CircularProgressIndicator(),
          
          // ОТОБРАЖЕНИЕ
          postsLoaded: (posts) => ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Айди поста:${post.id}", style: const TextStyle(fontWeight: FontWeight.normal)),
                  Text("Айди юзера: ${post.userId.toString()}", style: const TextStyle(fontWeight: FontWeight.normal)),
                  Text(post.body),
                ],
              ),
              );
            },
          ),

          // EXCEPTION
          error: (msg) => Text(msg),
    );
  },
)
    );
  }
}