import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_parser/data/models/post.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState{
  const factory PostState.loading() = _Loading;

  const factory PostState.postsLoaded({
    required List<Post> posts}) = _PostsLoaded;

    const factory PostState.error(String message) = _Error; 
}

// class _Loading {
//   const _Loading()
// }
// class _PostsLoaded {}
// class _Error {}