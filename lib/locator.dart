import 'package:get_it/get_it.dart';
import 'package:tracker/services/navigation_services.dart';
import 'storageRepo.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.reset();
  locator.registerLazySingleton(() => NavigationService);
  GetIt.instance.registerSingleton<StorageRepo>(StorageRepo());
}
