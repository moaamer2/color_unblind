import 'package:colors_blind/core/error/failure.dart';
import 'package:flutter/material.dart';

abstract class LiveColorCorrectionState {}

class LiveColorCorrectionInitial extends LiveColorCorrectionState {}



class LiveColorCorrectionLoadingState extends LiveColorCorrectionState {}

class LiveColorCorrectionErrorState extends LiveColorCorrectionState {
  final Failure failure;
  LiveColorCorrectionErrorState(this.failure);
}

class LiveColorCorrectionSuccessState extends LiveColorCorrectionState {
  final List<double>? _filterMatrix;
  LiveColorCorrectionSuccessState(List<double>? filterMatrix)
      : _filterMatrix = filterMatrix;

  ColorFilter? get colorFilter {
    if (_filterMatrix == null) return null;
    return ColorFilter.matrix(_filterMatrix);
  }
}