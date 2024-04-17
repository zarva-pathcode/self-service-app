import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/helper/constant.dart';
import 'package:self_service_app/models/order_table.dart';
import 'package:self_service_app/provider/barang_provider.dart';

class AnimatedOrderedListView extends StatelessWidget {
  final List<TableOrder> orderList;
  const AnimatedOrderedListView({
    Key? key,
    required this.orderList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat('#,##0', "en_US");
    var size = MediaQuery.of(context).size;
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          var tableOrder = orderList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1400),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Container(
                  height: size.width * .18,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * .045,
                  ).copyWith(bottom: size.width * .02),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .02,
                  ).copyWith(right: size.width * .05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.width * .035),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        offset: const Offset(2, 4),
                        blurRadius: 8,
                        // spreadRadius: ,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      tableOrder.photo == ""
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                vertical: size.width * .022,
                              ),
                              height: size.width * .3,
                              width: size.width * .175,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(
                                  size.width * .02,
                                ),
                              ),
                            )
                          : Container(
                              width: size.width * .175,
                              margin: EdgeInsets.symmetric(
                                vertical: size.width * .022,
                              ),
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
                                  "$remoteMenuImageURL/${tableOrder.photo}",
                                  height: size.width * .3,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: size.width * .05,
                      ),
                      Container(
                        width: size.width * .42,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tableOrder.namaBarang,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppAssets().mediumTStyle.copyWith(
                                    fontSize: size.width * .024,
                                  ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: size.width * .07,
                              width: size.width * .35,
                              child: Row(
                                children: [
                                  _incrementDecrementButton(
                                    context,
                                    size,
                                    isIncrement: false,
                                    index: index,
                                  ),
                                  SizedBox(
                                    width: size.width * .03,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius: BorderRadius.circular(
                                              size.width * .01)),
                                      child: Center(
                                        child: Text(
                                          "${orderList[index].jumlah}",
                                          style: AppAssets()
                                              .regularTStyle
                                              .copyWith(
                                                  fontSize: size.width * .03),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * .03,
                                  ),
                                  _incrementDecrementButton(
                                    context,
                                    size,
                                    isIncrement: true,
                                    index: index,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Rp.${currency.format(orderList[index].totalPerBarang)}",
                        style: AppAssets().mediumTStyle.copyWith(
                              fontSize: size.width * .032,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _incrementDecrementButton(BuildContext context, Size size,
      {required bool isIncrement, required int index}) {
    return GestureDetector(
      onTap: () {
        Provider.of<BarangProvider>(context, listen: false)
            .updateQty(isIncrement, index);
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppAssets().yellowColor,
            borderRadius: BorderRadius.circular(size.width * .015)),
        height: size.width * .07,
        width: size.width * .07,
        child: Icon(isIncrement ? Icons.add : Icons.remove,
            size: size.width * .04),
      ),
    );
  }
}
