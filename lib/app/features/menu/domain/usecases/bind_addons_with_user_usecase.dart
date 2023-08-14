part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindAddonsWithUserUseCase extends BindingUseCase<List<Addons>, AppUserEntity, DataSourceState<AppUserEntity>> {
  BindAddonsWithUserUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<AppUserEntity>> call({required List<Addons> source, required AppUserEntity destination}) async {
    return menuRepository.bindAddonsWithUser(source: source, destination: destination);
  }
}
