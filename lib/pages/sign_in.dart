import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/utils/language_select.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.language_rounded),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => SelectLanguagePage()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "welcome_to",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                    ),
                  ).tr(),
                  SizedBox(height: 5),
                  Text(
                    "app_title",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[850],
                      letterSpacing: 1.2,
                    ),
                  ).tr(),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'welcome_msg',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                      ),
                    ).tr(),
                    // SizedBox(height: 25),
                    CustomDivider(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: 4,
                      margin: EdgeInsets.only(top: 25),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SigninButton(
                    btnText: tr('signin_facebook'),
                    btnIcon: FontAwesome.facebook_f,
                    btnColor: Color(0xFF4267B2),
                    onPressed: () {
                      print("pressed google");
                    },
                  ),
                  SizedBox(height: 12),
                  SigninButton(
                    btnText: tr('signin_google'),
                    btnIcon: FontAwesome.google,
                    btnColor: Colors.lightBlue,
                    onPressed: () {},
                  ),
                  SizedBox(height: 12),
                  SigninButton(
                    btnText: tr('signin_email'),
                    btnIcon: Feather.mail,
                    btnColor: Colors.grey[700],
                    onPressed: () {},
                  ),
                  SizedBox(height: 12),
                  SigninButton(
                    btnText: tr('signin_apple'),
                    btnIcon: FontAwesome.apple,
                    btnColor: Colors.grey[900],
                    onPressed: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
