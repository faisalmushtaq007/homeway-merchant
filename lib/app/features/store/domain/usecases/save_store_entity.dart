import 'package:homemakers_merchant/app/features/store/domain/entities/store_entity.dart';
import 'package:homemakers_merchant/base/base_usecase.dart';

class SaveStoreEntity extends UseCaseIO<StoreEntity, int> {
  @override
  Future<int> call(StoreEntity input) async {
    throw UnimplementedError();
  }
}
