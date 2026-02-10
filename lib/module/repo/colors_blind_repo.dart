import 'package:colors_blind/core/data/local/local_data_source.dart';
import 'package:colors_blind/core/data/local/params/send_frames_local_data_source_params.dart';
import 'package:colors_blind/core/data/remote/remote_data_source.dart';
import 'package:colors_blind/core/error/failure.dart';
import 'package:colors_blind/core/services/internet_state/internet_state_service.dart';
import 'package:colors_blind/core/services/localization/locale_keys.g.dart';
import 'package:colors_blind/core/services/upload_image/upload_image_service.dart';
import 'package:colors_blind/core/data/remote/params/process_image_data_source_params.dart';
import 'package:colors_blind/module/repo/params/generate_image_params.dart';
import 'package:colors_blind/module/repo/params/process_image_params.dart';
import 'package:colors_blind/module/repo/params/send_frame_params.dart';
import 'package:dartz/dartz.dart';

class ColorsBlindRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final InternetStateService internetStateService;
  final UploadImageService uploadImageService;

  ColorsBlindRepo(
    this.remoteDataSource,
    this.localDataSource,
    this.internetStateService,
    this.uploadImageService,
  );

  Future<Either<Failure,List<double>>> getFilterMatrix(SendFrameParams params) async {
    try{
      final filterMatrix = await localDataSource.getFilterMatrix(
        SendFramesLocalDataSourceParams(
          colorBlindType: params.colorBlindType,
          brightness: params.brightness,
          processingType: params.processingType,
        ),
      );

      return Right(filterMatrix);
    }
    catch(e){
      return Left(Failure(message: e.toString(),),);
    }
  }



  Future<Either<Failure,String>> processImage(ProcessImageParams params) async {
    try{
      final isConnected = await internetStateService.isConnected();
      
      if (isConnected){
        final imageLink = await uploadImageService.uploadImage(params.image,);

        final processesImage = await remoteDataSource.processImage(
          ProcessDataSourceImageParams(
            imageURL: imageLink,
            colorBlindType: params.colorBlindType,
          ),
        );

        await uploadImageService.deleteImage();

        return Right(processesImage);
      }
      else{
        return Left(Failure(message: LocaleKeys.NoInternetConnection,),);
      }
    }
    catch(e){
      return Left(Failure(message: e.toString(),),);
    }
  }



  Future<Either<Failure,String>> generateImage(GenerateImageParams params) async {
    try{
      final image = await remoteDataSource.generateImageParams(params);
      return Right(image);
    }
    catch(e){
      return Left(Failure(message: e.toString(),),);
    }
  }
}