import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg/utils/config.dart';

class SelectLanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> appLanguages = AppConfig.appLanguages;
    return Scaffold(
      appBar: AppBar(
        title: Text('select_lang').tr(),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemCount: AppConfig.appLanguages.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemBuilder(context, appLanguages[index], index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 5);
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, String localeName, int index) {
    String locale = AppConfig.appLocales[index];
    return ListTile(
      leading: Icon(Icons.language),
      title: Text(localeName),
      trailing:
          (context.locale.toString() == locale) ? Icon(Icons.check) : null,
      onTap: () async {
        context.locale = Locale(AppConfig.appLocales[index]);
        Navigator.pop(context);
      },
    );
  }
}
