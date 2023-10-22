import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/homePage/assets/widgets/smallText.dart';

class IconAndTexWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;

  const IconAndTexWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
