part of 'package:homemakers_merchant/app/features/menu/index.dart';

class GetAllCategoryUseCase
    extends CategoryQueryAllUseCaseIORecord<Category, Category, int, int, String?, String?, String?, Timestamp?, Timestamp?, DataSourceState<List<Category>>> {
  GetAllCategoryUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<List<Category>>> call({
    int pageKey = 0,
    int pageSize = 20,
    String? searchText,
    Category? category,
    Category? subCategory,
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  }) async {
    return await menuRepository.getAllCategory();
  }
}
