import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/bookmark_bloc.dart';
import 'package:xplore_bg/bloc/category_list_bloc.dart';
import 'package:xplore_bg/bloc/feautured_bloc.dart';
import 'package:xplore_bg/bloc/internet_bloc.dart';
import 'package:xplore_bg/bloc/maps_api_bloc.dart';
import 'package:xplore_bg/bloc/popular_places_bloc.dart';
import 'package:xplore_bg/bloc/recent_places_bloc.dart';
import 'package:xplore_bg/bloc/review_bloc.dart';
import 'package:xplore_bg/bloc/search_bloc.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/bloc/similar_places_bloc.dart';
import 'package:xplore_bg/bloc/subcategory_list_bloc.dart';
import 'package:xplore_bg/pages/splash_page.dart';
import 'package:xplore_bg/utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(EasyLocalization(
    path: "assets/translations",
    supportedLocales: AppConfig.appLocales.map((item) => Locale(item)).toList(),
    fallbackLocale: Locale("bg"),
    startLocale: Locale("bg"),
    useOnlyLangCode: true,
    child: MyApp(),
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print(context.locale);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<InternetBloc>(create: (ctx) => InternetBloc()),
        ChangeNotifierProvider<SigninBloc>(create: (ctx) => SigninBloc()),
        ChangeNotifierProvider<SearchBloc>(create: (ctx) => SearchBloc()),
        ChangeNotifierProvider<FeaturedBloc>(create: (ctx) => FeaturedBloc()),
        ChangeNotifierProvider<BookmarkBloc>(create: (ctx) => BookmarkBloc()),
        ChangeNotifierProvider<ReviewBloc>(create: (ctx) => ReviewBloc()),
        ChangeNotifierProvider<MapsApiBloc>(create: (ctx) => MapsApiBloc()),
        ChangeNotifierProvider<PopularPlacesBloc>(
            create: (ctx) => PopularPlacesBloc()),
        ChangeNotifierProvider<RecentlyAddedPlacesBloc>(
            create: (ctx) => RecentlyAddedPlacesBloc()),
        ChangeNotifierProvider<SimilarPlacesBloc>(
            create: (ctx) => SimilarPlacesBloc()),
        ChangeNotifierProvider<CategoryListBloc>(
            create: (ctx) => CategoryListBloc()),
        ChangeNotifierProvider<SubcategoryListBloc>(
            create: (ctx) => SubcategoryListBloc()),
      ],
      child: MaterialApp(
        // title: 'Flutter Demo',
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        title: "Xplore Bulgaria",
        theme: ThemeData(
          primaryColor: Colors.cyan[700],
          appBarTheme: AppBarTheme(
            color: Colors.grey[50],
            elevation: 5,
            brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 18,
                color: Colors.grey[900],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
