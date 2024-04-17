import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/ui/set_qris_screen.dart';

class LoadingQrisScreen extends StatefulWidget {
  const LoadingQrisScreen({super.key});

  @override
  State<LoadingQrisScreen> createState() => _LoadingQrisScreenState();
}

class _LoadingQrisScreenState extends State<LoadingQrisScreen>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SetQrisScreen(),
        ),
      );
    });
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
              "Siapkan Handphone Untuk Melakukan Scan Barcode",
              style: AppAssets().mediumTStyle.copyWith(
                    fontSize: size.width * .04,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: size.width * .1,
          ),
          Center(
            child: SizedBox(
              height: size.width * .5,
              width: size.width * .5,
              child: LottieBuilder.asset(
                AppAssets().barcodeScanAnimation,
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ],
      ),
    );
  }
}
