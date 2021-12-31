import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/posts.dart';

class NavCubit extends Cubit<Post> {
  NavCubit() : super(Post(userId: 0, id: 0, title: '', body: ''));

  void showPostDetails(Post post) => emit(post);

  void popToPosts() => emit(Post(userId: 0, id: 0, title: '', body: ''));
}
