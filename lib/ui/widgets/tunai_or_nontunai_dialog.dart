// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/provider/transaksi_provider.dart';
import 'package:self_service_app/ui/widgets/debit_or_qris_dialog.dart';
import 'package:self_service_app/ui/payment_method_screen.dart';
import 'package:self_service_app/ui/set_receipt_screen.dart';
import 'package:self_service_app/ui/widgets/choice_box.dart';

import '../../helper/constant.dart';

class TunaiOrNontunaiDialog extends StatefulWidget {
  const TunaiOrNontunaiDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<TunaiOrNontunaiDialog> createState() => _TunaiOrNontunaiDialogState();
}

class _TunaiOrNontunaiDialogState extends State<TunaiOrNontunaiDialog>
    with TickerProviderStateMixin {
  PaymentState? paymentState;
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var productF = Provider.of<BarangProvider>(context, listen: false);
    var transactionF = Provider.of<TransaksiProvider>(context, listen: false);
    return Consumer<TransaksiProvider>(
      builder: (context, tData, ch) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              size.width * .06,
            ),
          ),
          height: size.width * .7,
          width: size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                // child: AnimatedCloseButton(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05,
                    vertical: size.width * .06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pilih Metode Pembayaran",
                        style: AppAssets().mediumTStyle.copyWith(
                              fontSize: size.width * .03,
                            ),
                      ),
                      SizedBox(
                        height: size.width * .04,
                      ),
                      Row(
                        children: [
                          SizedBox(height: size.width * .02),
                          Expanded(
                            child: ChoiceBox(
                              image: AppAssets().cash3d,
                              text: "Tunai",
                              padding: size.width * .05,
                              radius: size.width * .03,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const SetReceiptScreen(),
                                    duration: const Duration(milliseconds: 700),
                                    reverseDuration:
                                        const Duration(milliseconds: 600),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: size.width * .05),
                          Expanded(
                            child: ChoiceBox(
                              image: AppAssets().debitIcon,
                              text: "Non Tunai",
                              padding: size.width * .05,
                              radius: size.width * .03,
                              onTap: () {
                                Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     child: const PaymentMethodScreen(),
                                //     duration: const Duration(milliseconds: 700),
                                //     reverseDuration:
                                //         const Duration(milliseconds: 600),
                                //     type: PageTransitionType.rightToLeft,
                                //   ),
                                // );
                                showGeneralDialog(
                                  context: context,
                                  barrierLabel: "",
                                  barrierDismissible: true,
                                  transitionDuration:
                                      const Duration(milliseconds: 1000),
                                  transitionBuilder: (context, a1, a2, widget) {
                                    final curvedValue = Curves.easeInOutBack
                                            .transform(a1.value) -
                                        1.0;
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
                                          child: const DebitOrQrisDialog(),
                                        ),
                                      ),
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return const SizedBox();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
