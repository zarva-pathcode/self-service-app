import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/ui/widgets/animated_ordered_listview.dart';
import 'package:self_service_app/ui/widgets/main_button.dart';
import 'package:self_service_app/ui/widgets/tunai_or_nontunai_dialog.dart';

class OrderMenuScreen extends StatefulWidget {
  const OrderMenuScreen({super.key});

  @override
  State<OrderMenuScreen> createState() => _OrderMenuScreenState();
}

class _OrderMenuScreenState extends State<OrderMenuScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat('#,##0', "en_US");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<BarangProvider>(
        builder: (context, data, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideInUp(
              duration: const Duration(milliseconds: 1400),
              child: FadeIn(
                duration: const Duration(milliseconds: 2000),
                child: Center(
                  child: Image.asset(
                    AppAssets().waroengLogo,
                    height: size.width * .2,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SlideInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 2000),
                      child: Text(
                        "Pesanan Anda",
                        style: AppAssets()
                            .mediumTStyle
                            .copyWith(fontSize: size.width * .04),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .43,
                  ),
                  SlideInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: FadeIn(
                      duration: const Duration(milliseconds: 2000),
                      child: Text(
                        "Harga :",
                        style: AppAssets()
                            .mediumTStyle
                            .copyWith(fontSize: size.width * .03),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * .02,
            ),
            Flexible(
              child: AnimatedOrderedListView(
                orderList: data.listOfTableOrder,
              ),
            ),
            SizedBox(
              height: size.width * .04,
            ),
            SlideInUp(
              duration: const Duration(milliseconds: 1400),
              child: FadeIn(
                duration: const Duration(milliseconds: 2000),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .045),
                  child: Row(
                    children: [
                      Text(
                        "TOTAL :",
                        style: AppAssets()
                            .mediumTStyle
                            .copyWith(fontSize: size.width * .03),
                      ),
                      const Spacer(),
                      Text(
                        "Rp.${currency.format(data.subTotal)}",
                        style: AppAssets()
                            .mediumTStyle
                            .copyWith(fontSize: size.width * .045),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideInUp(
        duration: const Duration(milliseconds: 1400),
        child: FadeIn(
          duration: const Duration(milliseconds: 2000),
          child: SizedBox(
            height: size.width * .1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  isOutlined: true,
                  label: "Tambah Pesanan",
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: size.width * .06,
                ),
                MainButton(
                  isOutlined: false,
                  label: "Selesaikan Pesanan",
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierLabel: "",
                      barrierDismissible: true,
                      transitionDuration: const Duration(milliseconds: 1000),
                      transitionBuilder: (context, a1, a2, widget) {
                        final curvedValue =
                            Curves.easeInOutBack.transform(a1.value) - 1.0;
                        return Transform(
                          transform: Matrix4.translationValues(
                            0.0,
                            curvedValue * 200,
                            0.0,
                          ),
                          child: Opacity(
                            opacity: a1.value,
                            child: Dialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    size.width * .06,
                                  ),
                                ),
                              ),
                              child: const TunaiOrNontunaiDialog(),
                            ),
                          ),
                        );
                      },
                      pageBuilder: (context, animation1, animation2) {
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
