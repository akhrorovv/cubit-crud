import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo13/bloc/update_state.dart';

import '../models/post_model.dart';
import '../services/http_service.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  UpdateCubit() : super(UpdateInitialState());

  Future<void> onUpdatePost(Post post) async {
    emit(UpdateLoadingState());

    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    Post newPost = post;
    newPost.title = title;
    newPost.body = body;

    var response = await Network.PUT(Network.API_POST_UPDATE + newPost.id.toString(), Network.paramsUpdate(newPost));
    // LogService.d(response!);
    if(response != null){
      emit(UpdatedPostState(newPost));
    } else {
      emit(const UpdateErrorState('Could not delete post'));
    }
  }
}
