import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo13/bloc/create_state.dart';

import '../models/post_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CreateCubit extends Cubit<CreateState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  CreateCubit() : super(CreateInitialState());

  Future<void> onCreatePost() async {
    emit(CreateLoadingState());

    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();
    Post post = Post(userId: 1, title: title, body: body);

    var response =
        await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);
    if (response != null) {
      emit(CreatedPostState(post));
    } else {
      emit(const CreateErrorState('Could not delete post'));
    }

  }
}
