import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grocery_app_firebase/constant.dart';
import 'package:grocery_app_firebase/screens/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFE8E8E8),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: (size.height / 4)),
              child: RichText(
                text:
                    TextSpan(style: TextStyle(color: Colors.black), children: [
                  TextSpan(
                    text: 'DOGU MARKET\n',
                    style: Constant().kTextStyle_24,
                  ),
                  TextSpan(
                    text: '     GROCERY',
                    style: Constant().kTextStyle_24,
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2,
            left: -size.width / 2,
            child: Container(
              width: size.width * 2,
              height: (size.height * 2) / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF009D23).withOpacity(0.75),
                    Color(0xFF009D23).withOpacity(0.22),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(size.width, (size.height / 3)),
                ),
              ),
            ),
          ),
          Positioned(
            top: (size.height * 2) / 3,
            left: -(((size.width - ((size.height) / 6)) * 2) - size.width) / 2,
            child: Stack(
              children: [
                Container(
                  width: ((size.width - ((size.height) / 6)) * 2),
                  height: ((size.width - ((size.height) / 6)) * 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                        Radius.circular((size.width - ((size.height) / 6)))),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF69E876).withOpacity(0),
                        Color(0xFF7CDD86),
                        Color(0xFF7CDD86),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images_components/main_menu_photo.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: (size.height * 7) / 12 - 10,
            child: InkWell(
              onTap: () {
                print('pressed');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                width: size.width - 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFAFE7BB),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Center(
                    child: Text(
                  'GET STARTED',
                  style: Constant().kTextStyle_20,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
