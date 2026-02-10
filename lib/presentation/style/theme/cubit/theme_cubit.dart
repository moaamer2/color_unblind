import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:colors_blind/presentation/style/theme/color_collection_model.dart';
import 'package:colors_blind/presentation/style/theme/theme_model.dart';

class ThemeCubit extends HydratedCubit<AppTheme> {
  late final List<ColorCollection> _lightColorsCollections;
  late final List<ColorCollection> _darkColorsCollections;
  int? _index;
  bool? _isDark;

  ThemeCubit() : super(
    AppTheme(
      colorCollection: ColorCollection.defaultLightCollection(),
    ),
  ){
    _init();
  }

  void _init(){

    _lightColorsCollections = [
      ColorCollection.defaultLightCollection(),
    ];
  
    _darkColorsCollections = [
      ColorCollection.defaultDarkCollection(),
    ];
  
    toggleTheme(_isDark ?? false);
    changeTheme(_index ?? 0);
  }

  void changeTheme(int index){
    _index = index;
    if (_isDark ?? false) {
      emit(
        AppTheme(
          colorCollection: _darkColorsCollections[_index ?? 0],
        ),
      );
    }
    else{
      emit(
        AppTheme(
          colorCollection: _lightColorsCollections[_index ?? 0],
        ),
      );
    }
  }
  
  void toggleTheme(bool value){
    if (value) {
      _isDark = value;
      emit(
        AppTheme(
          colorCollection: _darkColorsCollections[_index ?? 0],
        ),
      );
    }
    else{
      _isDark = value;
      emit(
        AppTheme(
          colorCollection: _lightColorsCollections[_index ?? 0],
        ),
      );
    }
  }
  
  
  @override
  AppTheme? fromJson(Map<String, dynamic> json) {
    _index = json['index'];
    if (json['isDark'] == 0) {
      _isDark = true;
      return AppTheme(
        colorCollection: _darkColorsCollections[_index ?? 0],
      );
    }
    else{
      _isDark = false;
      return AppTheme(
        colorCollection: _lightColorsCollections[_index ?? 0],
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(AppTheme state) {
    return {
      'index': _index ?? 0,
      'isDark': (_isDark ?? false) ? 0 : 1,
    };
  }

  int get index => _index ?? 0;
  bool get isDark => _isDark ?? false;
  List<Color> get colors => _lightColorsCollections.map(
    (e) => e.primaryColor,
  ).toList();
}

