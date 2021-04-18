import 'package:get_it/get_it.dart';
import 'package:tracker/services/navigation_services.dart';
import 'storageRepo.dart';
//import 'services/user_service.dart';
//import 'services/login_service.dart';

//GetIt locator = GetIt.instance;
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.reset();
  locator.registerLazySingleton(() => NavigationService);
  GetIt.instance.registerSingleton<StorageRepo>(StorageRepo());

  //locator.registerSingleton(UserService());
  //locator.registerFactory<LoginService>(() => LoginService());
}
