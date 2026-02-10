import 'package:colors_blind/module/enums/processing_type.dart';
import 'package:colors_blind/module/models/color_blind_type.dart';
import 'package:colors_blind/module/repo/colors_blind_repo.dart';
import 'package:colors_blind/module/repo/params/send_frame_params.dart';
import 'package:colors_blind/presentation/views/video/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveColorCorrectionCubit extends Cubit<LiveColorCorrectionState> {
  final ColorsBlindRepo _repo;

  ProcessingType _processingType = ProcessingType.simulation;

  double _brightness = 50;
  ColorBlindType _type = ColorBlindType.normal;

  LiveColorCorrectionCubit(this._repo) : super(LiveColorCorrectionInitial());

  Future<void> _getMatrix() async {
    emit(LiveColorCorrectionLoadingState());

    final result = await _repo.getFilterMatrix(
      SendFrameParams(
        colorBlindType: _type,
        brightness: _brightness,
        processingType: _processingType,
      ),
    );

    result.fold(
      (failure) {
        emit(LiveColorCorrectionErrorState(failure));
      },
      (matrix) {
        emit(LiveColorCorrectionSuccessState(matrix));
      },
    );
  }


  @override
  void emit(LiveColorCorrectionState state) {
    if (! isClosed){
      super.emit(state);
    }
  }

  double get brightness => _brightness;
  set brightness(double value) {
    _brightness = value;
    _getMatrix();
  }
  ColorBlindType get type => _type;
  set type(ColorBlindType value) {
    _type = value;
    if (_type != ColorBlindType.normal) {
      _getMatrix();
    }
    else {
      emit(LiveColorCorrectionSuccessState(null));
    }
  }

  ProcessingType get processingType => _processingType;

  set processingType(ProcessingType value) {
    _processingType = value;
    if (_type != ColorBlindType.normal) {
      _getMatrix();
    }
    else {
      emit(LiveColorCorrectionSuccessState(null));
    }
  }
}