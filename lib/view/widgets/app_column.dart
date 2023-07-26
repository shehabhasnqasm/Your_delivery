import 'package:flutter/material.dart';
import 'package:food_delivary/model/product_model.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/big_text.dart';
import 'package:food_delivary/view/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final ProductModel roductModel;
  const AppColumn({super.key, required this.roductModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BigText(
          text: roductModel.name.toString(),
          size: Diamensions.font26,
        ),
        SizedBox(
          height: Diamensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(roductModel.stars ?? 5, (index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber, //AppCourse.mainColor,
                  size: 15,
                );
              }),
            ),
            SizedBox(width: Diamensions.width10),
            SmallText(text: "${roductModel.stars}/5"),
            SizedBox(width: Diamensions.width10),
            SmallText(text: "1149"),
            SizedBox(width: Diamensions.width10),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Diamensions.height20),
      ],
    );
  }
}
