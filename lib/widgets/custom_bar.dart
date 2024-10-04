import 'package:flutter/material.dart';

import 'colors.dart';
import 'custom_text.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/logo.png',width: 40,height: 40,),
            CustomText(
              text: 'Quick',
              color: CustomColors.primarycolor,

            ),
            CustomText(
              text: 'Buy',
              color: Colors.black,

            ),
          ],
        ),


        Row(
          children: [
            Image.asset('assets/phone.png',width: 40,height: 40,),
            Image.asset('assets/notification.png',width: 40,height: 40,),
          ],
        )

      ],
    );
  }
}
