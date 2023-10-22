import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/homePage/assets/widgets/smallText.dart';
import 'package:tcc_me_adote/app/pages/homePage/dog_page_body.dart';
import 'package:tcc_me_adote/app/pages/splash/splash_page.dart';
import 'assets/colors/colors.dart';
import 'assets/widgets/bigText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "Encontre seu pet",
                        color: HomeColors.blueColor,
                        size: 15,
                      ),
                      SmallText(
                        text: "Em qualquer lugar",
                        color: HomeColors.subColor,
                        size: 15,
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(
                        Icons.person,
                        color: HomeColors.whiteColor,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: HomeColors.blueColor),
                    ),
                  )
                ],
              ),
            ),
          ),
          DogPageBody(),
        ],
      ),
    );
  }
}
