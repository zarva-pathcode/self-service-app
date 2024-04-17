import 'package:flutter/material.dart';
import 'package:self_service_app/helper/app_assets.dart';

class ChoiceBox extends StatefulWidget {
  final String image;
  final double? padding;
  final double? radius;
  final String? text;
  final Function()? onTap;
  const ChoiceBox({
    super.key,
    required this.image,
    required this.padding,
    required this.radius,
    required this.text,
    this.onTap,
  });

  @override
  State<ChoiceBox> createState() => _ChoiceBoxState();
}

class _ChoiceBoxState extends State<ChoiceBox>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late bool _buttonPressed;
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
    _buttonPressed = false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      onVerticalDragEnd: _dragEnd,
      onHorizontalDragEnd: _dragEnd,
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: SizedBox(
        child: Column(
          children: [
            Transform.scale(
              scale: _scale,
              child: Container(
                height: size.width * .4,
                width: size.width * .5,
                padding: EdgeInsets.all(widget.padding!),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: _buttonPressed
                      ? []
                      : [
                          BoxShadow(
                            blurRadius: 10,
                            offset: const Offset(2, 4),
                            color: Colors.black.withOpacity(.15),
                          ),
                        ],
                  borderRadius: BorderRadius.circular(widget.radius!),
                  border: Border.all(color: AppAssets().yellowColor, width:size.width*.005),
                ),
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(
              height: size.width * .04,
            ),
            Text(
              widget.text!,
              textAlign: TextAlign.center,
              style: AppAssets().mediumTStyle.copyWith(
                    fontSize: size.width * .03,
                  ),
            )
          ],
        ),
      ),
    );
  }

  void _dragEnd(DragEndDetails details) {
    _controller.reverse();
    _buttonPressed = false;
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
    _buttonPressed = true;
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
    _buttonPressed = false;
  }
}
