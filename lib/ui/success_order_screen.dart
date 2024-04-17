import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:self_service_app/helper/app_assets.dart';

class SuccessOrderedScreen extends StatefulWidget {
  const SuccessOrderedScreen({super.key});

  @override
  State<SuccessOrderedScreen> createState() => _SuccessOrderedScreenState();
}

class _SuccessOrderedScreenState extends State<SuccessOrderedScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .1,
            ),
            child: Text(
              "Transaksi Berhasil. Pesanan Berhasil Ditambahkan...",
              style: AppAssets().mediumTStyle.copyWith(
                    fontSize: size.width * .04,
                  ),
                  textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.width * .2,
          ),
          Center(
            child: SizedBox(
              height: size.width * .45,
              width: size.width * .45,
              child: LottieBuilder.asset(
                AppAssets().successAnimation,
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ],
      ),
    );
  }
}
