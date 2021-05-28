import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/bloc/internet_bloc.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/home_page.dart';
import 'package:xplore_bg/utils/language_select.dart';
import 'package:xplore_bg/utils/misc.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String tag;

  const LoginScreen({Key key, this.tag}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _googleSigninStarted = false;
  bool _facebookSigninStarted = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Navigator.pop(context);
            handleSkip();
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
      body: Builder(
        builder: (BuildContext context) {
          return Center(
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
                      _buildSigninButton(
                        context,
                        btnText: tr('signin_google'),
                        btnIcon: FontAwesome.google,
                        btnColor: Colors.lightBlue,
                        onPressed: () => _handleGoogleSignIn(context),
                        loading: _googleSigninStarted,
                        // onPressed: () {
                        //   print("pressed google");
                        //   setState(() {
                        //     _googleSigninStarted = !_googleSigninStarted;
                        //   });
                        // },
                      ),
                      SizedBox(height: 12),
                      _buildSigninButton(
                        context,
                        btnText: tr('signin_facebook'),
                        btnIcon: FontAwesome.facebook_f,
                        btnColor: Color(0xFF4267B2),
                        onPressed: () {
                          print("pressed facebook");
                          setState(() {
                            _facebookSigninStarted = !_facebookSigninStarted;
                            showSnackbar(context, "Ttest msg!");
                          });
                        },
                        loading: _facebookSigninStarted,
                      ),
                      SizedBox(height: Platform.isIOS ? 12 : 0),
                      Platform.isIOS
                          ? SigninButton(
                              btnText: tr('signin_apple'),
                              btnIcon: FontAwesome.apple,
                              btnColor: Colors.grey[900],
                              onPressed: () {},
                            )
                          : Container(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSigninButton(
    BuildContext context, {
    @required String btnText,
    @required IconData btnIcon,
    @required Color btnColor,
    @required dynamic onPressed,
    double buttonHeight = 45.0,
    bool loading = false,
  }) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: loading
            ? Container(
                color: Colors.white38,
                child: Center(
                  child: SizedBox(
                    width: buttonHeight * 0.6,
                    height: buttonHeight * 0.6,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Icon(
                      btnIcon,
                      size: buttonHeight * 0.48, // 21
                      color: Colors.white,
                    ),
                  ),
                  CustomDivider(
                    height: buttonHeight * 0.36,
                    width: 1,
                    color: Colors.grey[350],
                    margin: EdgeInsets.only(right: 15),
                  ),
                  // SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      btnText,
                      style: TextStyle(
                        fontSize: buttonHeight * 0.36, //16.5
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      onTap: onPressed,
    );
  }

  void handleSkip() {
    final SigninBloc sb = context.read<SigninBloc>();
    sb.setGuestUser();
    if (widget.tag == null) {
      nextScreenMaterial(context, HomePage());
    } else {
      Navigator.pop(context);
    }
  }

  void _handleGoogleSignIn(BuildContext ctx) async {
    final signinBloc = context.read<SigninBloc>();
    final internetBlock = context.read<InternetBloc>();
    setState(() => _googleSigninStarted = true);
    await internetBlock.checkConnectivity();
    if (internetBlock.hasInternet == false) {
      showSnackbar(
        ctx,
        // _scaffoldKey,
        'check your internet connection!'.tr(),
      );
    } else {
      await signinBloc.signInWithGoogle().then((_) {
        if (signinBloc.hasError == true) {
          showSnackbar(
            ctx,
            'something went wrong. please try again.',
          );
          setState(() => _googleSigninStarted = false);
        } else {
          signinBloc.checkIfUserExists().then((value) {
            if (value == true) {
              signinBloc.getUserDataFromFirebase(signinBloc.uid).then(
                    (value) => signinBloc
                        .saveDataToSP()
                        .then((value) => signinBloc.guestSignout())
                        .then(
                          (value) => signinBloc.setSignIn().then(
                            (value) {
                              setState(() => _googleSigninStarted = false);
                              _afterSignIn();
                            },
                          ),
                        ),
                  );
            } else {
              signinBloc.getJoinDate().then(
                    (value) => signinBloc.saveToFirebase().then(
                          (value) => signinBloc.saveDataToSP().then(
                                (value) => signinBloc.guestSignout().then(
                                      (value) =>
                                          signinBloc.setSignIn().then((value) {
                                        setState(
                                            () => _googleSigninStarted = false);
                                        _afterSignIn();
                                      }),
                                    ),
                              ),
                        ),
                  );
            }
          });
        }
      });
    }
  }

  void _afterSignIn() {
    if (widget.tag == null) {
      // nextScreenReplaceMaterial(context, HomePage());
      nextScreenCloseOthers(context, HomePage());
    } else {
      Navigator.pop(context);
    }
  }
}
