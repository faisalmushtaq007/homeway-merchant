import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/menu/presentation/widgets/category_card_widget.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';

class SubCategoryListView extends StatelessWidget {
  const SubCategoryListView({
    super.key,
    this.selectedCategory,
    this.data = const [],
  });
  final List<Category> data;
  final Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ...List.generate(data.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CategoryCardWidget(
                category: data[index],
                isPreview: false,
                isThreaded: true,
                showHeadline: index == 0,
                isMainCategory: false,
              ),
            );
          }),
        ],
      ),
    );
  }
}
