import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/ui/dinein_ta_screen.dart';

class SetQrisScreen extends StatefulWidget {
  const SetQrisScreen({super.key});

  @override
  State<SetQrisScreen> createState() => _SetQrisScreenState();
}

class _SetQrisScreenState extends State<SetQrisScreen> {
  bool isSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 6),
      () {
        setState(() {
          isSuccess = true;
        });
        Future.delayed(
          const Duration(seconds: 10),
          () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DineinTAScreen()),
              (route) => false,

            );
            Provider.of<BarangProvider>(context,listen: false).resetOrder();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .1,
            ),
            child: SlideInRight(
              duration: const Duration(milliseconds: 1700),
              child: FadeIn(
                duration: const Duration(milliseconds: 1200),
                child: Text(
                  "Silahkan Scan Barcode dibawah",
                  style: AppAssets().mediumTStyle.copyWith(
                        fontSize: size.width * .04,
                      ),
                  textAlign: TextAlign.center,
                )
                    .animate(target: isSuccess ? 1 : 0)
                    .fadeOut(duration: const Duration(milliseconds: 300))
                    .swap(
                      builder: (_, __) => Text(
                        "Transaksi Berhasil. Pesanan Berhasil Ditambahkan, Terimakasih...",
                        style: AppAssets().mediumTStyle.copyWith(
                              fontSize: size.width * .04,
                            ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(),
                    ),
              ),
            ),
          ),
          SizedBox(
            height: size.width * .1,
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: isSuccess
                  ? SizedBox(
                      key: const ValueKey("2"),
                      height: size.width * .45,
                      width: size.width * .45,
                      child: LottieBuilder.asset(
                        AppAssets().successAnimation,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : SlideInRight(
                      duration: const Duration(milliseconds: 1700),
                      child: FadeIn(
                        duration: const Duration(milliseconds: 1200),
                        child: SizedBox(
                          key: const ValueKey("1"),
                          height: size.width * .5,
                          width: size.width * .5,
                          child: Image.asset(
                            AppAssets().scanMeBarcode,
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
