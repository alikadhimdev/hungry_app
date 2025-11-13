import 'package:flutter/material.dart';

import '../../../shared/custom_text.dart';
import '../view/product_view.dart';

class AdditionalCard extends StatelessWidget {
  const AdditionalCard({super.key, required this.adds});
  final List<ProductAdds> adds;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(adds.length, (index) {
          return Card(
            color: Color(0xff3C2F2F),
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(adds[index].img),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: SizedBox(
                    width: 90,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: adds[index].title,
                          color: Colors.white,
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                        Spacer(),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),

                          child: Center(
                            child: CustomText(
                              text: "+",
                              color: Colors.white,
                              size: 14,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
