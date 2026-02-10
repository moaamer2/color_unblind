import 'dart:io';

import 'package:camera/camera.dart';
import 'package:colors_blind/core/extensions/context/navigation.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/style/app_colors.dart';
import 'package:colors_blind/presentation/style/theme/cubit/theme_cubit.dart';
import 'package:colors_blind/presentation/widgets/adaptive_loading_indicator.dart';

class VideoRecordingWidget extends StatefulWidget {
  final void Function(CameraImage image)? onSendFrame;
  final ColorFilter? colorFilter;

  const VideoRecordingWidget({
    super.key,
    this.onSendFrame,
    this.colorFilter,
  });

  @override
  State<VideoRecordingWidget> createState() => _VideoRecordingWidgetState();
}

class _VideoRecordingWidgetState extends State<VideoRecordingWidget> {
  // available cameras in device
  List<CameraDescription> cameras = [];
  
  // camera controller to switch between cameras and send video frames
  CameraController? cameraController;

  // show second camera
  bool _secondCameraShown = false;

  // debaounce time to protect ai model from high fram rate
  // mobile app is too much faster that the ai model so it's important to make 
  // it slower to synchronize with ai model
  DateTime? lastChangeTime;

  // init widget state 
  @override
  void initState() {
    super.initState();

    // init camera
    _setCameraController();
  }

  // dispose widget
  @override
  void dispose() {
    // dispose camera
    cameraController?.dispose();
    super.dispose();
  }

  // send frames to controller cubit
  void sendframes(CameraImage image){
    if (widget.onSendFrame != null) {
      widget.onSendFrame!(image);
    }
  }

  // init camera
  Future<void> _setCameraController() async {
    // get available cameras
    final List<CameraDescription> cameras = await availableCameras();

    // if detected at least one camera
    if (cameras.isNotEmpty) {
      setState(() {
        // set available cameras
        this.cameras = cameras;

        // set camera controller
        cameraController = CameraController(
          cameras[_secondCameraShown ? 0 : 1],
          ResolutionPreset.ultraHigh,
          imageFormatGroup: ImageFormatGroup.yuv420,
        );
      });

      // await camera initialization then start frame stream
      cameraController!.initialize().then(
        (_) {
          setState(() {});
          if (widget.onSendFrame != null){
            cameraController!.startImageStream((CameraImage image) {
              sendframes(image);
            });
          }
        },
      );
    } 
  }


  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    // camera switching button and camera preview are in a column
    return Column(
      children: [
        // camera switcher widget
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 5.fromWidth.max(10)),
          child: Row(
            children: [
              // back button
              GestureDetector(
                onTap: (){
                  context.pop();
                },
                child: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  color: AppColors.darkGrey,
                  size: (Platform.isIOS ? 25 : 30).staticRadius,
                ),
              ),

              // space between
              SizedBox(width: 10.staticWidth,),

              // switch text
              Text(
                context.tr(LocaleKeys.switchCamera),
                style: TextStyle(
                  color: themeCubit.state.textColor,
                  fontSize: 16.textScale,
                ),
              ),
          
              // space between
              SizedBox(width: 8.staticWidth,),
          
              // switch icon
              GestureDetector(
                onTap: () {
                  setState(() {
                    _secondCameraShown = !_secondCameraShown;
                    _setCameraController();
                  });
                },
          
                child: Icon(
                  Icons.cameraswitch_outlined,
                  color: AppColors.red,
                  size: 20.textScale,
                ),
              ),
            ],
          ),
        ),

        // space between
        SizedBox(height: 16.staticHeight),

        // camera preview
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(16.fromRadius.max(20))
            ),

            child: isCameraAvailable ? ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16.fromRadius.max(20)),
              child: ColorFiltered(
                colorFilter: widget.colorFilter ?? ColorFilter.mode(
                  AppColors.transparent,
                  BlendMode.srcOver,
                ),
                child: CameraPreview(cameraController!),
              ),
            ) : Center(
              child: AdaptiveLoadingIndicator(
                color: themeCubit.state.primaryColor,
                androidSize: 21,
                iOSsize: 11,
                androidWidth: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }


  bool get isCameraAvailable => cameras.isNotEmpty &&
  cameraController != null && cameraController?.value.isInitialized == true;
}
