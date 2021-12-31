import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/data_service.dart';
import 'package:post_app/posts.dart';

class PostsCubit extends Cubit<List<Post>> {
  final _dataService = DataService();
  PostsCubit() : super([]);

  void getPosts() async => emit(await _dataService.getPosts());
}

abstract class PostEvent {}

class LoadPostEvent extends PostEvent {}

class PoolToRefreshEvent extends LoadPostEvent {}

abstract class PostsState {}

class LoadingPostState extends PostsState {}

class LoadedPostState extends PostsState {
  List<Post> posts;
  LoadedPostState({required this.posts});
}

class FailedToLoadPostState extends PostsState {
  String error;
  FailedToLoadPostState({required this.error});
}

class PostBloc extends Bloc<PostEvent, PostsState> {
  final _dataService = DataService();

  PostBloc() : super(LoadingPostState()) {
    on<LoadPostEvent>(loadPostEv);
    on<PoolToRefreshEvent>(loadPostEv);
  }

  FutureOr<void> loadPostEv(
      LoadPostEvent event, Emitter<PostsState> emit) async {
    emit(LoadingPostState());
    try {
      final posts = await _dataService.getPosts();
      emit(LoadedPostState(posts: posts));
    } catch (e) {
      emit(FailedToLoadPostState(error: "Something Goes Wrong"));
    }
  }
}
