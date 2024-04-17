// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:self_service_app/helper/app_assets.dart';

import '../../provider/barang_provider.dart';

class MainButton extends StatefulWidget {
  final bool isOutlined;
  final String label;
  final Function()? onTap;
  const MainButton({
    Key? key,
    required this.isOutlined,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton>
    with SingleTickerProviderStateMixin {

  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 60,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    var barangProvider = Provider.of<BarangProvider>(context, listen: false);
    _scale = 1 - _controller.value;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      onVerticalDragEnd: _dragEnd,
      onHorizontalDragEnd: _dragEnd,
      child: Transform.scale(
        scale: _scale,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width * .3,
          ),
          child: Container(
            padding:  EdgeInsets.symmetric(vertical: size.width*.02, horizontal: size.width*.02,),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.width*.03),
                border: widget.isOutlined
                    ? Border.all(
                        color: AppAssets().yellowColor,
                        width: size.width * .004,
                      )
                    : null,
                gradient: widget.isOutlined
                    ? null
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffFFD200),
                          Color(
                            0xffF7971E,
                          ),
                        ],
                      ),
                boxShadow: widget.isOutlined
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          offset: const Offset(2, 4),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]),
            child: Center(
              child: Text(
                widget.label,
                style: AppAssets().mediumTStyle.copyWith(
                    fontSize: size.width*.026,
                    color: widget.isOutlined ? Colors.black : Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

   void _dragEnd(DragEndDetails details) {
    _controller.reverse();
    // _buttonPressed = false;
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
    // _buttonPressed = true;
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    // _buttonPressed = false;
  }
}
