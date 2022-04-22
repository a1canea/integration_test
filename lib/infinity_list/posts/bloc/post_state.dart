import 'package:equatable/equatable.dart';

import '../models/post.dart';

enum PostStatus {
  initial,
  success,
  failure,
}

class PostState with EquatableMixin {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.hasReachedMax = false,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];

  @override
  String toString() {
    return 'PostState{status: $status, posts: ${posts.length}, hasReachedMax: $hasReachedMax}';
  }
}
