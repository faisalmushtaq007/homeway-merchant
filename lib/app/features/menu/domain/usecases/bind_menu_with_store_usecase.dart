part of 'package:homemakers_merchant/app/features/menu/index.dart';

class BindMenuWithStoreUseCase extends BindingUseCase<List<MenuEntity>, List<StoreEntity>, DataSourceState<List<MenuEntity>>> {
  BindMenuWithStoreUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<List<MenuEntity>>> call({required List<MenuEntity> source, required List<StoreEntity> destination}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
