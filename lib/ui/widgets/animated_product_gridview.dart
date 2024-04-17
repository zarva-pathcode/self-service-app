// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:self_service_app/provider/barang_provider.dart';
// import 'package:self_service_app/ui/widgets/product_menu_card.dart';

// class AnimatedProductGridView extends StatelessWidget {
//   final BarangProvider data;
//   final ScrollController scrollController;
//   const AnimatedProductGridView({
//     Key? key,
//     required this.data,
//     required this.scrollController,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return AnimationLimiter(
//       child: GridView.builder(
//         controller: scrollController,
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.only(
//           top: size.width * .005,
//           left: size.width * .005,
//           right: size.width * .005,
//           bottom: size.width * .01,
//         ),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: size.width * .02,
//           crossAxisSpacing: size.width * .02,
//           childAspectRatio: 1.5,
//         ),
//         itemCount: barangList.length,
//         itemBuilder: (BuildContext context, int i) {
//           var barang = barangList[i];
//           return AnimationConfiguration.staggeredGrid(
//             position: i,
//             duration: const Duration(milliseconds: 500),
//             columnCount: 3,
//             child: ScaleAnimation(
//               child: FadeInAnimation(
//                 child: ProductMenuCard(
//                   barang: barang,
//                   isSelected: true,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
