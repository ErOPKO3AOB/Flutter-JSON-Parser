import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:json_parser/data/repositories/post_repository.dart';
import 'package:json_parser/features/posts/bloc/post_event.dart';
import 'package:json_parser/features/posts/bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._repository) : super(const PostState.loading()) {
    on<PostEvent>(
      (event, emit) => switch(event) {
        PostRequestEvent() => _request(event, emit),
      }, transformer: sequential());
  }

  final PostRepository _repository;

  Future<void> _request(PostRequestEvent event, Emitter<PostState> emit) async {
    emit(const PostState.loading()); 

    try {
      final posts = await _repository.fetchPosts();

      emit(PostState.postsLoaded(posts: posts)); 
    } catch (e) {
      emit(PostState.error(e.toString()));
    }
  }
}