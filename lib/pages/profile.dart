import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xplore_bg/bloc/signin_bloc.dart';
import 'package:xplore_bg/pages/sign_in.dart';
import 'package:xplore_bg/utils/config.dart';
import 'package:xplore_bg/utils/language_select.dart';
import 'package:xplore_bg/utils/page_navigation.dart';
import 'package:xplore_bg/utils/popup_dialogs.dart';
import 'package:xplore_bg/widgets/profile/user_ui.dart';

class ProfilePage extends StatefulWidget {
  final String tag;

  const ProfilePage({Key key, this.tag}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  double _tileIconSize = 30;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final SigninBloc _signinBloc = context.watch<SigninBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('menu_user_profile').tr(),
        automaticallyImplyLeading: (widget.tag != null),
        actions: [
          _signinBloc.isSignedIn
              ? IconButton(
                  icon: Icon(Feather.log_out),
                  onPressed: () => _confirmLogout(context),
                )
              : IconButton(
                  icon: Icon(Feather.log_in),
                  onPressed: () {
                    nextScreenPopup(context, LoginScreen(tag: "login"));
                  },
                ),
        ],
      ),
      body: ListView(
        children: [
          _signinBloc.isSignedIn
              ? UserProfileUI(
                  logoutCallback: () {
                    _confirmLogout(context);
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: _listTile(
                    context,
                    icon: Feather.log_in,
                    text: tr('signin_btn'),
                    color: Colors.orangeAccent,
                    onPress: () {
                      nextScreenPopup(context, LoginScreen(tag: "login"));
                    },
                  ),
                ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "general_settings",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ).tr(),
                SizedBox(height: 20),
                ListTile(
                  title: Text("select_lang").tr(),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.globe,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => SelectLanguagePage()));
                  },
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("feedback").tr(),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.mail,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                  onTap: () async {
                    await canLaunch(AppConfig.mailto)
                        ? await launch(AppConfig.mailto)
                        : throw 'Could not launch ${AppConfig.mailto}';
                  },
                ),
                Divider(height: 5),
                ListTile(
                  title: Text("about_app").tr(),
                  leading: Container(
                    height: _tileIconSize,
                    width: _tileIconSize,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(_tileIconSize * 0.2),
                    ),
                    child: Icon(
                      Feather.info,
                      size: _tileIconSize * 0.65,
                      color: Colors.white,
                    ),
                  ),
                  trailing:
                      Icon(Feather.chevron_right, size: _tileIconSize * 0.65),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile(
    BuildContext context, {
    double iconSize = 30,
    @required IconData icon,
    Function onPress,
    @required String text,
    Color color,
  }) {
    return ListTile(
      title: Text(text),
      leading: Container(
        height: iconSize,
        width: iconSize,
        decoration: BoxDecoration(
          color: color ?? Colors.purpleAccent,
          borderRadius: BorderRadius.circular(iconSize * 0.2),
        ),
        child: Icon(icon, size: iconSize * 0.65, color: Colors.white),
      ),
      trailing: Icon(Feather.chevron_right, size: iconSize * 0.65),
      onTap: onPress,
    );
  }
}

void _confirmLogout(BuildContext context) {
  showYesNoDialog(
    context,
    () async {
      Navigator.pop(context);
      await context
          .read<SigninBloc>()
          .userSignout()
          .then((_) => nextScreenCloseOthers(context, LoginScreen()));
    },
    title: tr('logout'),
    message: tr('logout_hint'),
  );
}
