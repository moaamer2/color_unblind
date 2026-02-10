import 'dart:io';

import 'package:colors_blind/module/models/color_blind_type.dart';
import 'package:colors_blind/module/repo/colors_blind_repo.dart';
import 'package:colors_blind/module/repo/params/generate_image_params.dart';
import 'package:colors_blind/module/repo/params/process_image_params.dart';
import 'package:colors_blind/presentation/views/image_processing/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessImageCubit extends Cubit<ProcessImageState> {
  final ColorsBlindRepo _repo;
  ColorBlindType colorBlindType = ColorBlindType.protanopia;

  ProcessImageCubit(this._repo) : super(ProcessImageInitial());



  Future<void> processImage(File image) async {
    emit(ProcessImageLoadingState());

    final result = await _repo.processImage(
      ProcessImageParams(
        image: image,
        colorBlindType: colorBlindType,
      )
    );


    result.fold(
      (failure){
        emit(ProcessImageErrorState(failure));
      },
      (url){
        emit(ProcessImageSuccessState(url));
      }
    );
  }



  Future<void> generateImage(String description) async {
    emit(ProcessImageLoadingState());

    final result = await _repo.generateImage(
      GenerateImageParams(
        description: description,
        colorBlindType: colorBlindType,
      )
    );

    result.fold(
      (failure){
        emit(ProcessImageErrorState(failure));
      },
      (url){
        emit(ProcessImageSuccessState(url));
      }
    );
  }
}