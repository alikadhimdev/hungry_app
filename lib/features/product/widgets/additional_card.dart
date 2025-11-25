import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class AdditionalCard extends StatelessWidget {
  const AdditionalCard({
    super.key,
    required this.image,
    required this.name,

    this.onTap,
    required this.isSelected,
  });
  final String image;
  final String name;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? AppColors.primary : Color(0xff3C2F2F),
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.warning_rounded, size: 30),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: name,
                    color: Colors.white,
                    size: 12,
                    weight: FontWeight.w400,
                  ),

                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.redAccent,
                      shape: BoxShape.circle,
                    ),

                    child: isSelected
                        ? Icon(Icons.check, size: 12, color: Colors.white)
                        : Icon(Icons.add, size: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
