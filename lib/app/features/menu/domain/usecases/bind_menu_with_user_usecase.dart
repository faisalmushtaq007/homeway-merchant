part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindMenuWithUserUseCase extends BindingUseCase<List<MenuEntity>, AppUserEntity, DataSourceState<AppUserEntity>> {
  BindMenuWithUserUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<AppUserEntity>> call({required List<MenuEntity> source, required AppUserEntity destination}) async {
    return menuRepository.bindMenuWithUser(source: source, destination: destination);
  }
}
