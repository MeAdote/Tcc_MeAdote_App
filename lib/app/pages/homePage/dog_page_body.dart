import 'package:flutter/material.dart';
import 'package:tcc_me_adote/app/pages/homePage/assets/colors/colors.dart';
import 'package:tcc_me_adote/app/pages/homePage/assets/widgets/bigText.dart';
import 'package:tcc_me_adote/app/pages/homePage/assets/widgets/iconAndText.dart';
import 'package:tcc_me_adote/app/pages/homePage/assets/widgets/smallText.dart';

class DogPageBody extends StatefulWidget {
  const DogPageBody({super.key});

  @override
  State<DogPageBody> createState() => _DogPageBodyState();
}

class _DogPageBodyState extends State<DogPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _pagAtual = 0.0;
  double _scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _pagAtual = pageController.page!;
        print("Pagina Atual " + _pagAtual.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.redAccent,
      height: 320,
      child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, position) {
            return _buildPageItem(position);
          }),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _pagAtual.floor()) {
      var esqAtual = 1 - (_pagAtual - index) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, esqAtual, 1);
    } else if (index == _pagAtual.floor() + 1) {
      var esqAtual =
          _scaleFactor + (_pagAtual - index + 1) * (1 - _scaleFactor);
      matrix = Matrix4.diagonal3Values(1, esqAtual, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 220,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/golden.png'))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: "Golden"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(Icons.star,
                                color: HomeColors.lightBlueColor, size: 15);
                          }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "sei la"),
                        SizedBox(
                          height: 10,
                        ),
                        SmallText(text: "aa"),
                        SizedBox(
                          height: 10,
                        ),
                        SmallText(text: "bb"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        IconAndTexWidget(
                            icon: Icons.circle_sharp,
                            text: "teste",
                            iconColor: HomeColors.lightBlueColor),
                        IconAndTexWidget(
                            icon: Icons.location_on,
                            text: "distancia",
                            iconColor: HomeColors.tituloColor),
                        IconAndTexWidget(
                            icon: Icons.access_time_rounded,
                            text: "teste",
                            iconColor: HomeColors.subColor),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
