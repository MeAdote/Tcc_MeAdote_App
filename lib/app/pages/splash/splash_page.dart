import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: constraints.maxWidth * 0.1,
                        height: constraints.maxWidth * 0.1,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Image.asset(
                    'assets/images/inicial.png',
                    width: constraints.maxWidth * 0.7,
                    height: constraints.maxWidth * 0.7,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Container(
                    width: constraints.maxWidth * 0.9,
                    child: Text(
                      'Compreendemos que o processo de adoção de um animal, muitas vezes não resulta como o esperado, como um animal que não está em condições para ser adotado ou um tutor que não apresenta estrutura para tal.',
                      style: TextStyle(fontSize: 13.3),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.15),
                  Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.04),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pets');
                      },
                      child: Text('Acessar'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(230, 50)),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/rotaLogin');
                    },
                    child: Text('Já tem uma conta?'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
