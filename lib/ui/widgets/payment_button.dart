// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/transaksi_provider.dart';

import '../../helper/constant.dart';

class PaymentButton extends StatefulWidget {
  final TransaksiProvider tData;
  final bool isTunai;
  final Function()? onTap;
  final Function(bool)? onHover;
  final String label;
  final IconData icon;
  const PaymentButton({
    Key? key,
    required this.tData,
    this.onTap,
    this.onHover,
    required this.isTunai,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton>
    with TickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  PaymentState? paymentState;
  bool isHovering = false;
  PaymentState? stateOfPayment;

  @override
  void initState() {
    super.initState();
    setStateOfPayment(widget.isTunai);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: .03,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  setStateOfPayment(bool state) {
    if (state == true) {
      stateOfPayment = PaymentState.onHoverTunai;
      print(stateOfPayment);
    } else {
      stateOfPayment = PaymentState.onHoverNonTunai;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _scale = 1 + _controller.value;
    return InkWell(
      onTap: widget.onTap,
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          decoration: paymentState == stateOfPayment
              ? BoxDecoration(
                  color: Colors.blue[100]!.withOpacity(.1),
                  border: Border.all(color: Colors.blue[400]!),
                  borderRadius: BorderRadius.circular(
                    size.width * .025,
                  ),
                )
              : BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(
                    size.width * .025,
                  ),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.icon,
                color: paymentState == stateOfPayment
                    ? Colors.blue[400]
                    : Colors.grey[300],
                size: size.width * .035,
              ),
              SizedBox(
                width: size.width * .015,
              ),
              Text(
                widget.label,
                style: AppAssets().regularTStyle.copyWith(
                  fontSize: size.width * .035,
                  fontWeight: paymentState == stateOfPayment
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: paymentState == stateOfPayment
                      ? Colors.blue[400]
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _tapUp(TapUpDetails details) {
    _controller.forward();
  }
}
