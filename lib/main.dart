import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/nav_cubit.dart';
import 'package:post_app/posts_cubit.dart';
import 'package:post_app/posts_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavCubit()),
          BlocProvider<PostBloc>(
            // create: (context) => PostsCubit()..getPosts(),
            create: (context) => PostBloc()..add(LoadPostEvent()),
          )
        ],
        child: const PostsView(),
      ),
    );
  }
}
