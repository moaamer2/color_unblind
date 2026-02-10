import 'package:colors_blind/core/extensions/locale/language_name.dart';
import 'package:colors_blind/core/extensions/num/resposive_ui_helper.dart';
import 'package:colors_blind/presentation/widgets/option_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSwithcer extends StatelessWidget {
  const LanguageSwithcer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OptionSwitcher<Locale>.colorsBlind(
      context,
      height: 23.fromHeight.max(30),
      getLable: (item) => item.name,
      width: 100.fromRadius.max(120),
      initValue: context.locale,
      items: const [Locale('en'), Locale('ar')],
      onSelect: (locale,index){
        context.setLocale(locale);
      },
    );
  }
}
