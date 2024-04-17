import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/models/barang.dart';
import 'package:self_service_app/provider/barang_provider.dart';

import '../../helper/constant.dart';

class ProductMenuCard extends StatefulWidget {
  final Barang barang;
  final bool isSelected;
  const ProductMenuCard({
    Key? key,
    required this.barang,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<ProductMenuCard> createState() => _ProductMenuCardState();
}

class _ProductMenuCardState extends State<ProductMenuCard>
    with TickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
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
    var barangF = Provider.of<BarangProvider>(context, listen: false);
    _scale = 1 - _controller.value;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.isSelected
          ? null
          : () {
              barangF.addToOrder(
                widget.barang,
                onResponse: () {
                  // showGeneralDialog(
                  //   context: context,
                  //   transitionDuration: const Duration(milliseconds: 300),
                  //   barrierDismissible: true,
                  //   barrierLabel: "",
                  //   transitionBuilder: (context, a1, a2, widget) {
                  //     return Transform.scale(
                  //       scale: a1.value,
                  //       child: Opacity(
                  //         opacity: a1.value,
                  //         child: Dialog(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(
                  //               size.width * .006,
                  //             ),
                  //           ),
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                 horizontal: size.width * .005,
                  //                 vertical: size.width * .02,
                  //               ),
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(
                  //                   size.width * .006,
                  //                 ),
                  //               ),
                  //               height: size.width * .1,
                  //               width: size.width * .02,
                  //               child: Column(
                  //                 children: [
                  //                   FaIcon(
                  //                     FontAwesomeIcons.xmark,
                  //                     size: size.width * .04,
                  //                     color: Colors.red,
                  //                   ),
                  //                   const Spacer(),
                  //                   Text(
                  //                     "Barang sudah masuk ke dalam pesanan",
                  //                     style: regularText.copyWith(
                  //                         fontSize: size.width * .01,
                  //                         color: Colors.black),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   pageBuilder: (context, animation1, animation2) {
                  //     return const SizedBox();
                  //   },
                  // );
                },
              );
            },
      onTapDown:widget.isSelected
          ? null
          :  _tapDown,
      onTapUp:widget.isSelected
          ? null
          :  _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: widget.isSelected ? _unselectedCard(size) : _selectedCard(size),
      ),
    );
  }

  _unselectedCard(Size size) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02)
              .copyWith(bottom: size.width * .015),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff1cfdd6),
                Color(0xff61fa74),
                Color(0xffdbf26e),
              ],
            ),
            borderRadius: BorderRadius.circular(size.width * .04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * .02,
              ),
              Container(
                height: size.width * .15,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    size.width * .02,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    size.width * .02,
                  ),
                  child: Image.network(
                    "$remoteMenuImageURL/${widget.barang.photo}",
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.white,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: size.width * .008,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.barang.nama!,
                      style: AppAssets().regularTStyle.copyWith(fontSize: size.width*.022),
                      textAlign: TextAlign.center,
                      // minFontSize: size.width*.01,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: size.width * .005,
                    ),
                    Text(
                      "Rp.${currency.format(int.tryParse(widget.barang.harga!))}",
                      style: AppAssets().mediumTStyle.copyWith(fontSize: size.width*.022),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: size.width * .015,
          right: size.width * .015,
          child: GestureDetector(
            onTap: () {
              Provider.of<BarangProvider>(context, listen: false)
                  .removeBarangById(widget.barang.kdBrg!);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * .02),
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              height: size.width * .06,
              width: size.width * .11,
              child: Center(
                child: Text(
                  "Batal",
                  style: AppAssets().regularTStyle.copyWith(
                        color: Colors.white,
                        fontSize: size.width * .026,
                      ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _selectedCard(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * .02)
          .copyWith(bottom: size.width * .015),
      decoration: BoxDecoration(
        color: AppAssets().yellowColor,
        borderRadius: BorderRadius.circular(size.width * .04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.width * .02,
          ),
          Container(
            height: size.width * .15,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size.width * .02,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                size.width * .02,
              ),
              child: Image.network(
                "$remoteMenuImageURL/${widget.barang.photo}",
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: size.width * .008,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.barang.nama!,
                   style: AppAssets().regularTStyle.copyWith(fontSize: size.width*.022),
                    textAlign: TextAlign.center,
                  // minFontSize: 11,
                  maxLines: 2,
                ),
                SizedBox(
                  height: size.width * .005,
                ),
                Text(
                  "Rp.${currency.format(int.tryParse(widget.barang.harga!))}",
                 style: AppAssets().mediumTStyle.copyWith(fontSize: size.width*.022),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                )
              ],
            ),
          ),
        ],
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
