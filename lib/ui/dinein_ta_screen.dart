import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/ui/pay_on_the_spot_screen.dart';
import 'package:self_service_app/ui/widgets/choice_box.dart';

class DineinTAScreen extends StatelessWidget {
  const DineinTAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var edgeMargin = size.width * .07;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.width * .2,
          ),
          SlideInDown(
            duration: const Duration(milliseconds: 800),
            child: FadeIn(
              duration: const Duration(milliseconds: 1300),
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
            height: size.width * .5,
            child: Row(
              children: [
                SizedBox(
                  width: edgeMargin,
                ),
                Expanded(
                  child: SlideInLeft(
                    duration: const Duration(milliseconds: 800),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1300),
                      child: ChoiceBox(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            child: const PayOnTheSpotScreen(),
                            duration: const Duration(milliseconds: 800),
                            reverseDuration: const Duration(milliseconds: 600),
                            type: PageTransitionType.rightToLeft,
                          ),
                        ),
                        image: AppAssets().dineinImage,
                        padding: size.width * .02,
                        radius: size.width * .04,
                        text: "Dine In",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .08,
                ),
                Expanded(
                  child: SlideInRight(
                    duration: const Duration(milliseconds: 800),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 1300),
                      child: ChoiceBox(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            child: const PayOnTheSpotScreen(),
                            duration: const Duration(milliseconds: 800),
                            reverseDuration: const Duration(milliseconds: 600),
                            type: PageTransitionType.rightToLeft,
                          ),
                        ),
                        image: AppAssets().takeAwayImage,
                        padding: size.width * .02,
                        radius: size.width * .04,
                        text: "Take Away",
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
