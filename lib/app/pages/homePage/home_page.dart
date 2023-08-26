import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/splash/splash_page.dart';

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.notifications_none),
                            color: Colors.grey,
                            onPressed: ((() {})),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.person),
                        color: Colors.blue,
                        onPressed: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Splash()),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
