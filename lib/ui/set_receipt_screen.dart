import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/ui/dinein_ta_screen.dart';

class SetReceiptScreen extends StatefulWidget {
  const SetReceiptScreen({super.key});

  @override
  State<SetReceiptScreen> createState() => _SetReceiptScreenState();
}

class _SetReceiptScreenState extends State<SetReceiptScreen> {
  bool isSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      const Duration(seconds: 4),
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
            Provider.of<BarangProvider>(context, listen: false)
                .resetOrder();
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
            child: FadeInRight(
              duration: const Duration(milliseconds: 1200),
              child: Text(
                "Pesananmu sedang diproses",
                style: AppAssets().mediumTStyle.copyWith(
                      fontSize: size.width * .04,
                    ),
                textAlign: TextAlign.center,
              )
                  .animate(target: isSuccess ? 1 : 0)
                  .fadeOut(duration: const Duration(milliseconds: 300))
                  .swap(
                    builder: (_, __) => Text(
                      "Pemesanan Berhasil. Ambil Struk dan Silahkan Melakukan Pembayaran Tunai Dikasir...",
                      style: AppAssets().mediumTStyle.copyWith(
                            fontSize: size.width * .04,
                          ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(),
                  ),
            ),
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: isSuccess
                  ? SizedBox(
                      key: const ValueKey("2"),
                      height: size.width * .7,
                      width: size.width * .7,
                      child: LottieBuilder.asset(
                        AppAssets().receiptAnimation,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : SizedBox(
                      key: const ValueKey("1"),
                      height: size.width * .6,
                      width: size.width * .6,
                      child: LottieBuilder.asset(
                        AppAssets().loadingBarAnimation,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
