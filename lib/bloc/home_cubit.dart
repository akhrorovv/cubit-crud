import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo13/bloc/create_cubit.dart';
import 'package:ngdemo13/bloc/home_state.dart';
import 'package:ngdemo13/bloc/update_cubit.dart';

import '../models/post_model.dart';
import '../pages/create_page.dart';
import '../pages/update_page.dart';
import '../services/http_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<Post> posts = [];

  Future<void> onLoadPostList() async {
    emit(HomeLoadingState());

    var response = await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());

    if (response != null) {
      var result = Network.parsePostList(response);
      posts.addAll(result);
      emit(HomePostListState(posts));
    } else {
      emit(HomeErrorState('Could not fetch posts'));
    }
  }

  Future<void> onDeletePost(Post post) async {
    emit(HomeLoadingState());

    var response = await Network.DEL(
        Network.API_POST_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      emit(HomeDeletePostState(post));
    } else {
      emit(HomeErrorState('Could not delete post'));
    }
  }

  Future callCreatePage(BuildContext context) async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => CreateCubit(),
            child: CreatePage(),
          );
        },
      ),
    );

    if (result) {
      onLoadPostList();
    }
  }

  Future callUpdatePage(BuildContext context, Post post) async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => UpdateCubit(),
            child: UpdatePage(post: post),
          );
        },
      ),
    );

    if (result) {
      onLoadPostList();
    }
  }
}
