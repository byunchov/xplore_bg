import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/profile.dart';
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
                      nextScreenMaterial(context, ProfilePage());
                    }
                  },
                ),
              ],
            ),
            //search placeholder
            _searchBar(context),
            // _buildFloatingSearchBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
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
    );
  }
}
