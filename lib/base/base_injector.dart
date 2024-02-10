import 'package:meta/meta.dart';
abstract class BaseInjector {
  const BaseInjector();
  void registerStateManagement();

  void registerDataSource();

  void registerRepository();

  void registerUseCase();

  @nonVirtual
  void register(){
    registerDataSource();
    registerRepository();
    registerUseCase();
    registerStateManagement();
  }
}
