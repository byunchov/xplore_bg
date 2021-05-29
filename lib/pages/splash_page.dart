import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/home_page.dart';
import 'package:xplore_bg/pages/sign_in.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/page_navigation.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  afterSplash() {
    final SigninBloc sb = context.read<SigninBloc>();
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      sb.isSignedIn == true || sb.guestUser == true
          ? gotoHomePage()
          : gotoSignInPage();
    });
  }

  gotoHomePage() {
    final SigninBloc sb = context.read<SigninBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSP();
    }
    nextScreenReplaceMaterial(context, HomePage());
  }

  gotoSignInPage() {
    nextScreenReplaceMaterial(context, LoginScreen());
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.forward();
    afterSplash();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: _controller,
            curve: Curves.decelerate,
          ),
          child: Image(
            image: AssetImage(AppConfig.appLogo),
            height: _screenWidth * 0.5,
            width: _screenWidth * 0.5,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
