import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/ui/main_menu_screen.dart';
import 'package:self_service_app/ui/widgets/choice_box.dart';

class PayOnTheSpotScreen extends StatelessWidget {
  const PayOnTheSpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var edgeMargin = size.width * .07;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: size.width * .2,
          ),
          SlideInRight(
            duration: const Duration(milliseconds: 1000),
            child: FadeIn(
              duration: const Duration(milliseconds: 1700),
              child: SizedBox(
                width: size.width * .5,
                height: size.width * .2,
                child: Image.asset(
                  "assets/wssteak_logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.width * .26,
          ),
          SizedBox(
            height: size.width * .6,
            child: Row(
              children: [
                SizedBox(
                  width: edgeMargin,
                ),
                Expanded(
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1700),
                      child: ChoiceBox(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            child: const MainMenuScreen(),
                            duration: const Duration(milliseconds: 1000),
                            reverseDuration: const Duration(milliseconds: 800),
                            type: PageTransitionType.rightToLeft,
                          ),
                        ),
                        image: AppAssets().kasirIcon,
                        padding: size.width * .04,
                        radius: size.width * .04,
                        text: "Bayar Dikasir (Tunai & Non Tunai)",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .08,
                ),
                Expanded(
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 1000),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1700),
                      child: ChoiceBox(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            child: const MainMenuScreen(),
                            duration: const Duration(milliseconds: 1000),
                            reverseDuration: const Duration(milliseconds: 800),
                            type: PageTransitionType.rightToLeft,
                          ),
                        ),
                        image: AppAssets().cashlessIcon,
                        padding: size.width * .02,
                        radius: size.width * .04,
                        text: "Disini (Non Tunai)",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: edgeMargin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
