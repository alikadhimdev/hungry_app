import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({
    super.key,
    required this.selectedIndex,
    required this.categories,
  });
  final int selectedIndex;
  final List categories;

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? AppColors.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: CustomText(
                  text: widget.categories[index],
                  size: 15,
                  weight: _selectedIndex == index
                      ? FontWeight.bold
                      : FontWeight.w500,
                  color: _selectedIndex == index
                      ? Colors.white
                      : AppColors.primary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
