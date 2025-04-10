import 'package:get_it/get_it.dart';
import 'package:ivitasa_app/states/notifications/notifications_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  ///
  static void init() {
    injectServices();
    initFeatures();
    initControllers();
  }

  /// Services
  static void injectServices() {}

  /// Features
  static void initFeatures() {}

  /// controllers
  static void initControllers() {
    sl.registerSingleton(NotificationsBloc());
  }
}
