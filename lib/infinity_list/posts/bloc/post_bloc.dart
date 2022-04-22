import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:test_project/infinity_list/posts/models/post.dart';

import './post_event.dart';
import '../../../infinity_list/posts/bloc/post_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({
    required this.httpClient,
  }) : super(PostState()) {
    on<PostFetched>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          posts: posts,
          status: PostStatus.success,
          hasReachedMax: false,
        ));
      }
      final posts = await _fetchPosts(state.posts.length);
      if (posts.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        emit(state.copyWith(
          hasReachedMax: false,
          posts: List.of(state.posts)..addAll(posts),
          status: PostStatus.success,
        ));
      }

      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ),
      );

    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await http.get(Uri.https(
      'jsonplaceholder.typicode.com',
      '/posts',
      {
        '_start': '$startIndex',
        '_limit': '$_postLimit',
      },
    ));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;

      return body.map((json) {
        return Post(
          userId: json['userId'] as int,
          title: json['title'] as String,
          id: json['id'] as int,
          body: json['body'] as String,
        );
      }).toList();
    }

    throw Exception('error fetching posts');
  }
}
