import 'package:colors_blind/presentation/widgets/dark_mode_switcher_widget.dart';
import 'package:colors_blind/presentation/widgets/language_swithcer.dart';
import 'package:flutter/material.dart';

class DarkModeAndLanguageWidget extends StatelessWidget {
  const DarkModeAndLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isrtl = Directionality.of(context) == TextDirection.rtl;

    return Transform.flip(
      flipX: isrtl,
      child: Row(
        children: [
          // language switcher
          Transform.flip(
            flipX: isrtl,
            child: LanguageSwithcer(),
          ),
      
          // space between
          const Spacer(),
      
          // dark mode switcher
          Transform.flip(
            flipX: isrtl,
            child: DarkModeSwitcherWidget(),
          ),
        ],
      ),
    );
  }
}
