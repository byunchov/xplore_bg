import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/profile.dart';
import 'package:xplore_bg/pages/search_page.dart';
import 'package:xplore_bg/pages/sign_in.dart';
import 'package:xplore_bg/utils/custom_cached_network_image.dart';
import 'package:xplore_bg/utils/page_navigation.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SigninBloc _signinBloc = Provider.of<SigninBloc>(context);
    return Container(
      color: Colors.grey[200],
      // color: Colors.cyan[700].withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "app_title",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[800]),
                    ).tr(),
                    SizedBox(height: 3),
                    Text(
                      "app_description",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ).tr(),
                  ],
                ),
                Spacer(),
                InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _signinBloc.imageUrl == null ||
                              !_signinBloc.isSignedIn
                          ? Icon(
                              Feather.user,
                              color: Colors.white,
                              size: 27,
                            )
                          : ClipOval(
                              child: CustomCachedImage(
                                imageUrl: _signinBloc.imageUrl,
                              ),
                            ),
                    ),
                  ),
                  onTap: () {
                    if (!_signinBloc.isSignedIn) {
                      nextScreenMaterial(context, LoginScreen(tag: "login"));
                    } else {
                      nextScreenMaterial(context, ProfilePage(tag: "profile"));
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            //search placeholder
            _searchBar(context),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          nextScreenMaterial(context, SearchPage());
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[500], width: 0.4),
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Icon(
                  LineIcons.search,
                  size: 20,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "search_places".tr(),
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
