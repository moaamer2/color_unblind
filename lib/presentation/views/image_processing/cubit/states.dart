import 'package:colors_blind/core/error/failure.dart';

abstract class ProcessImageState {}


class ProcessImageInitial extends ProcessImageState {}



class ProcessImageLoadingState extends ProcessImageState {}

class ProcessImageSuccessState extends ProcessImageState {
  final String image;
  ProcessImageSuccessState(this.image);
}

class ProcessImageErrorState extends ProcessImageState {
  final Failure failure;
  ProcessImageErrorState(this.failure);
}