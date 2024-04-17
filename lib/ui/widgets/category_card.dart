import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/models/kategori.dart';
import 'package:self_service_app/provider/barang_provider.dart';

class CategoryCard extends StatefulWidget {
  final Kategori kategori;
  final int indexList;
  final int selectedIndexKategori;
  final Function()? onTap;
  const CategoryCard(
      {Key? key,
      required this.kategori,
      required this.indexList,
      required this.selectedIndexKategori,
      required this.onTap})
      : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard>
    with TickerProviderStateMixin {
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
      onTap: () {
        widget.onTap!();
        barangProvider.setBarangByKategori(widget.indexList);
      },
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: size.width,
            minHeight: size.width * .25,
          ),
          child: widget.selectedIndexKategori == widget.indexList
              ? Container(
                  margin:  EdgeInsets.only(bottom: size.width*.012),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]!),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffFFE14D),
                        Color(
                          0xFFFFFCF5,
                        ),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      size.width * .035,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.kategori.icon,
                        height: size.width * .12,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        height: size.width * .01,
                      ),
                      Text(
                        widget.kategori.nama,
                        style: AppAssets()
                            .mediumTStyle
                            .copyWith(fontSize: size.width * .022),
                      ),
                    ],
                  ),
                )
              : _unselectedCategory(context),
        ),
      ),
    );
  }

  Widget _unselectedCategory(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width,
          height: size.width * .16,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(
              size.width * .035,
            ),
          ),
          child: Image.asset(
            widget.kategori.icon,
            height: size.width * .12,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(
          height: size.width * .02,
        ),
        Text(
          widget.kategori.nama,
          style: AppAssets().mediumTStyle.copyWith(fontSize: size.width * .022),
        ),
      ],
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
