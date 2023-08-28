import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/menu/presentation/widgets/category_card_widget.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'search_bar.dart' as search_bar;

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    this.selectedIndex,
    this.onSelected,
    this.allCategories = const [],
  });

  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final List<Category> allCategories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          search_bar.SearchBar(),
          const SizedBox(height: 8),
          ...List.generate(
            allCategories.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CategoryCardWidget(
                  category: allCategories[index],
                  onSelected: onSelected != null
                      ? () {
                          onSelected!(index);
                        }
                      : null,
                  isSelected: selectedIndex == index,
                  isMainCategory: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
