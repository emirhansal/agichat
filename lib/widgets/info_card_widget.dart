import 'package:agichat/resources/_r.dart';
import 'package:agichat/widgets/widgets_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetInfoCard extends StatefulWidget {
  const WidgetInfoCard({super.key});

  @override
  State<WidgetInfoCard> createState() => _WidgetInfoCardState();
}

class _WidgetInfoCardState extends State<WidgetInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 44, right: 30, top: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/user.png',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5.0),
          TextBasic(
            text: 'Esin \nErdem',
            color: R.color.black,
            fontSize: 36.0,
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              TextBasic(
                text: 'Designer',
                color: R.color.appTextColor,
                fontSize: 14,
              ),
              Icon(
                CupertinoIcons.circle_fill,
                color: R.color.gray,
                size: 5.0,
              ),
              Icon(
                Icons.star,
                color: R.color.appTextColor,
                size: 12.0,
              ),
              TextBasic(
                text: '4.5',
                color: R.color.appTextColor,
                fontSize: 14,
              )
            ],
          ),
          const SizedBox(height: 20.0),
          TextBasic(
            color: R.color.black,
            fontSize: 16.0,
            text:
                'Esin is a passionate designer specializing in branding. With a keen eye for detail and a love for innovation, she crafts visually stunning designs that tell compelling stories.',
          ),
        ],
      ),
    );
  }
}
