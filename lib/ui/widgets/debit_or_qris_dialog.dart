// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/provider/transaksi_provider.dart';
import 'package:self_service_app/ui/loading_qris_screen.dart';
import 'package:self_service_app/ui/payment_method_screen.dart';
import 'package:self_service_app/ui/set_debitcard_payment_screen.dart';
import 'package:self_service_app/ui/set_qris_screen.dart';
import 'package:self_service_app/ui/set_receipt_screen.dart';
import 'package:self_service_app/ui/widgets/choice_box.dart';

import '../../../helper/constant.dart';

class DebitOrQrisDialog extends StatefulWidget {
  const DebitOrQrisDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<DebitOrQrisDialog> createState() => _DebitOrQrisDialogState();
}

class _DebitOrQrisDialogState extends State<DebitOrQrisDialog>
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
                        "Pilih Metode Pembayaran (NON TUNAI)",
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
                              image: AppAssets().creditCardTerminalIcon,
                              text: "Kartu Debit",
                              padding: size.width * .05,
                              radius: size.width * .03,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const SetDebitPaymentScreen(),
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
                              image: AppAssets().qrisIcon,
                              text: "QRIS",
                              padding: size.width * .0,
                              radius: size.width * .03,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const LoadingQrisScreen(),
                                    duration: const Duration(milliseconds: 700),
                                    reverseDuration:
                                        const Duration(milliseconds: 600),
                                    type: PageTransitionType.rightToLeft,
                                  ),
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
