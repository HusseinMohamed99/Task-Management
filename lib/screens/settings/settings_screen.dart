import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/shared/components/size_box.dart';
import 'package:task_management/shared/providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static const String routeName = 'SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
         'theme',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold,fontSize: 20),
        ),
        const Space(width: 0, height: 8),
        InkWell(
          onTap: () {
          //  showThemeBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 1)),
            child: Text(
              settingsProvider.isDarkMode()
                  ?'dark'
                  : 'light',
              style:settingsProvider.currentLanguage =='en' ?  Theme.of(context).textTheme.headline4 :  Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20,fontWeight: FontWeight.bold),

            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
         'language',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold,fontSize: 20),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
           // showLanguageBottomSheet();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border:
                    Border.all(color: Theme.of(context).accentColor, width: 1)),
            child: Text(
              settingsProvider.currentLanguage =='en'
                  ? 'english'
                  : 'arabic',

              style:settingsProvider.currentLanguage =='en' ?  Theme.of(context).textTheme.headline4 :  Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }

  // void showThemeBottomSheet() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (buildContext) {
  //         return const ThemeBottomSheet();
  //       });
  // }

  // void showLanguageBottomSheet() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (buildContext) {
  //         return const LanguageBottomSheet();
  //       });
  // }
}
