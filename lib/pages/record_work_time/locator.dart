import 'package:get_it/get_it.dart';
import 'package:organics_salary/pages/record_work_time/camera.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
}
