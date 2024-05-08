import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo13/bloc/update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitialState());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();


}