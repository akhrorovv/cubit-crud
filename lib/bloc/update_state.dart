import 'package:equatable/equatable.dart';
import 'package:ngdemo13/models/post_model.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object?> get props => [];
}

class UpdateInitialState extends UpdateState {}

class UpdateLoadingState extends UpdateState {}

class UpdateErrorState extends UpdateState {
  final String errorMessage;

  const UpdateErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class UpdatedPostState extends UpdateState {
  final Post post;

  const UpdatedPostState(this.post);

  @override
  List<Object?> get props => [post];
}