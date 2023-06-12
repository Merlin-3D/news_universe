import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/dimens.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';
import 'package:news_universe/src/features/settings/components/option_item.dart';
import 'package:news_universe/src/viewmodels/theme_changer.dart';
import 'package:news_universe/src/shared/utils/sized_extension.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isNotification = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(builder: (context, themeChanger, _) {
      final currentTheme = themeChanger.getTheme();
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
            elevation: 1,
            title: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: kNewsWhite),
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.padding.w),
          child: Column(
            children: [
              SizedBox(
                height: Dimens.doubleSpace.h,
              ),
              OtionItem(
                  title: 'Display language',
                  onPressed: () {},
                  description:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting '),
              SizedBox(
                height: Dimens.space.h,
              ),
              const Divider(),
              SizedBox(
                height: Dimens.space.h,
              ),
              OtionItem(
                  title: 'Display Mode',
                  onPressed: () {},
                  description:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting '),
              SizedBox(
                height: Dimens.space.h,
              ),
              const Divider(),
              SizedBox(
                height: Dimens.space.h,
              ),
              OtionItem(
                  title: 'Change Theme',
                  displaySwitch: true,
                  switchValue: currentTheme == themeChanger.darkTheme,
                  onSwitchChanged: (value) {
                    final newTheme = value
                        ? themeChanger.darkTheme
                        : themeChanger.lightTheme;
                    themeChanger.setTheme(newTheme);
                  },
                  description:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting '),

              // OtionItem(
              //     title: 'Notification',
              //     displaySwitch: true,
              //     switchValue: isNotification,
              //     onSwitchChanged: (p0) {
              //       setState(() {
              //         isNotification = !isNotification;
              //       });
              //     },
              //     description:
              //         'Lorem Ipsum is simply dummy text of the printing and typesetting '),
              SizedBox(
                height: Dimens.space.h,
              ),
              const Divider(),
              OtionItem(
                  isSimple: true,
                  onPressed: () {},
                  title: 'Avis',
                  description: 'Lorem Ipsum is simply'),
              SizedBox(
                height: Dimens.space.h,
              ),
              const Divider(),
              SizedBox(
                height: Dimens.space.h,
              ),
              OtionItem(
                  isSimple: true,
                  onPressed: () {},
                  title: 'About',
                  description: 'Lorem Ipsum is simply dummy.'),
            ],
          ),
        ),
      );
    });
  }
}
