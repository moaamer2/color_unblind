import 'package:colors_blind/core/data/local/local_data_source.dart';
import 'package:colors_blind/core/data/local/providers/local_data_source_filters_implementation.dart';
import 'package:colors_blind/core/data/remote/api/dio/restful_api_handler_dio_impl.dart';
import 'package:colors_blind/core/data/remote/api/restful_api_handler.dart';
import 'package:colors_blind/core/data/remote/remote_data_source.dart';
import 'package:colors_blind/core/data/remote/remote_data_source_api_implementation.dart';
import 'package:colors_blind/core/services/internet_state/internet_state_service.dart';
import 'package:colors_blind/core/services/internet_state/internet_state_service_internet_plus_implementation.dart';
import 'package:colors_blind/core/services/upload_image/supabase/upload_image_service_supabase_implementation.dart';
import 'package:colors_blind/core/services/upload_image/upload_image_service.dart';
import 'package:colors_blind/module/repo/colors_blind_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initDI (){
  getIt.registerFactory<InternetStateService>(
    () => InternetStateServiceInternetPlusImplementation(),
  );

  getIt.registerSingleton<RestfulApiHandler>(
    RestfulApiHandlerDioImpl(getIt()),
  );


  getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceApiImplementation(getIt()),);



  getIt.registerSingleton<LocalDataSource>(LocalDataSourceFiltersImplementation(),);


  getIt.registerFactory<UploadImageService>(
    () => UploadImageServiceSupabaseImplementation(),
  );


  getIt.registerFactory<ColorsBlindRepo>(
    () => ColorsBlindRepo(getIt(), getIt(), getIt(), getIt()),
  );
}