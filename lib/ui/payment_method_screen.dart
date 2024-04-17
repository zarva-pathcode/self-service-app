import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/transaksi_provider.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  ScrollController gridViewScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TransaksiProvider>(context, listen: false).getAlatBayar());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TransaksiProvider>(
        builder: (context, data, child) {
          return Column(
            children: [
              Center(
                child: Image.asset(
                  AppAssets().waroengLogo,
                  height: size.width * .2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih Jenis Pembayaran",
                      style: AppAssets()
                          .mediumTStyle
                          .copyWith(fontSize: size.width * .035),
                    ),
                    SizedBox(
                      width: size.width * .43,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.width * .02,
              ),

              // Expanded(
              //   child: data.alatBayarIsLoading
              //       ? const Center(
              //           child: CircularProgressIndicator(),
              //         )
              //       : AnimationLimiter(
              //           child: GridView.builder(
              //             controller: gridViewScroll,
              //             padding:
              //                 EdgeInsets.symmetric(horizontal: size.width * .05)
              //                     .copyWith(bottom: size.width * .16),
              //             physics: const BouncingScrollPhysics(),
              //             gridDelegate:
              //                 const SliverGridDelegateWithFixedCrossAxisCount(
              //               childAspectRatio: 9 / 9,
              //               crossAxisCount: 3, // number of items in each row
              //               mainAxisSpacing: 18, // spacing between rows
              //               crossAxisSpacing: 18, // spacing between columns
              //             ),
              //             itemCount: data
              //                 .listOfAlatBayar.length, // total number of items
              //             itemBuilder: (context, index) {
              //               var alatBayar = data.listOfAlatBayar[index];
              //               return AnimationConfiguration.staggeredGrid(
              //                 position: index,
              //                 duration: const Duration(milliseconds: 1300),
              //                 columnCount: 3,
              //                 child: ScaleAnimation(
              //                   child: InkWell(
              //                     onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>SuccessOrderedScreen())),
              //                     child: Container(
              //                       padding: EdgeInsets.all(size.width * .05),
              //                       decoration: BoxDecoration(
              //                           color: Colors.white,
              //                           borderRadius: BorderRadius.circular(
              //                             size.width * .04,
              //                           ),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Colors.black.withOpacity(.15),
              //                               offset: const Offset(0, 2),
              //                               blurRadius: 10,
              //                               spreadRadius: 0,
              //                             ),
              //                           ]),
              //                       child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(
              //                           size.width * .02,
              //                         ),
              //                         child: Image.network(
              //                           "$remoteAlatBayarImageURL/${alatBayar.photo}",
              //                           errorBuilder:
              //                               (context, error, stackTrace) =>
              //                                   Container(
              //                             color: Colors.white,
              //                           ),
              //                           loadingBuilder:
              //                               (context, child, loadingProgress) {
              //                             if (loadingProgress == null) {
              //                               return child;
              //                             }
              //                             return Center(
              //                               child: CircularProgressIndicator(
              //                                 strokeWidth: 2,
              //                                 value: loadingProgress
              //                                             .expectedTotalBytes !=
              //                                         null
              //                                     ? loadingProgress
              //                                             .cumulativeBytesLoaded /
              //                                         loadingProgress
              //                                             .expectedTotalBytes!
              //                                     : null,
              //                               ),
              //                             );
              //                           },
              //                           fit: BoxFit.cover,
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              // )
            ],
          );
        },
      ),
    );
  }
}
