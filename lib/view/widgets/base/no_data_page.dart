import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;

  const NoDataPage({
    Key? key,
    required this.text,
    this.imgPath = "assets/images/empty_box.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Image.asset(
            "assets/images/food13.png",
            // imgPath,
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(text,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.0175,
                color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center),
      ],
    );
  }
}
