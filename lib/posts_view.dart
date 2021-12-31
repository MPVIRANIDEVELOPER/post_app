import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/posts_cubit.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: BlocBuilder<PostBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedPostState) {
            return RefreshIndicator(
              onRefresh: () async =>
                  BlocProvider.of<PostBloc>(context)..add(PoolToRefreshEvent()),
              child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.posts[index].title),
                      ),
                    );
                  }),
            );
          } else if (state is FailedToLoadPostState) {
            return Center(
              child: Container(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
