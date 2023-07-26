import 'package:flutter/material.dart';
import 'package:food_delivary/utils/colors.dart';
import 'package:food_delivary/utils/diamensions.dart';
import 'package:food_delivary/view/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  // textHeight = 150
  double textHeight = Diamensions.screenHeight / 5.3;

  bool isTextHidden = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Diamensions.height15),
      child: secondHalf.isEmpty
          ? SmallText(
              color: Colors.black, //AppCourse.pareColor,
              size: Diamensions.font16,
              fontHeight: 1.8,
              text: firstHalf)
          : Column(
              children: [
                SmallText(
                  color: Colors.black, //AppCourse.pareColor,
                  size: Diamensions.font16,
                  fontHeight: 1.8,
                  text: isTextHidden
                      ? firstHalf + "...".toString()
                      : firstHalf + secondHalf,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isTextHidden = !isTextHidden;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SmallText(
                          size: Diamensions.font16,
                          fontHeight: 1.8,
                          color: AppCourse.mainColor,
                          text: isTextHidden ? "show more" : "show less"),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          color: AppCourse.mainColor,
                          isTextHidden
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
