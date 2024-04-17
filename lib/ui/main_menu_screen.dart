import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:self_service_app/helper/app_assets.dart';
import 'package:self_service_app/provider/barang_provider.dart';
import 'package:self_service_app/ui/order_menu_screen.dart';
import 'package:self_service_app/ui/widgets/category_card.dart';
import 'package:self_service_app/ui/widgets/main_button.dart';
import 'package:self_service_app/ui/widgets/product_menu_card.dart';

class MainMenuScreen extends StatefulWidget {
  static const ROUTE_NAME = '/main-menu';

  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin {
  ScrollController gridViewScroll = ScrollController();
  final currency = NumberFormat('#,##0', "en_US");
  int theIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BarangProvider>(context, listen: false).getAllBarang());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final barangProvider = Provider.of<BarangProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<BarangProvider>(
        builder: (context, data, child) => SizedBox(
          child: Column(
            children: [
              SlideInRight(
                duration: const Duration(milliseconds: 1200),
                child: FadeIn(
                  duration: const Duration(milliseconds: 1600),
                  child: CarouselSlider(
                    items: bannernya
                        .map(
                          (e) => Builder(
                            builder: (context) => Container(
                              width: size.width * 1,
                              color: Colors.white,
                              child: Image.asset(
                                e,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: size.width * .35,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 10),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.5,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.width * .03,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * .18,
                        height: size.height,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets().waroengLogo,
                              height: size.width * .06,
                              width: size.width,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: size.width * .04,
                            ),
                            Expanded(
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      EdgeInsets.only(bottom: size.width * .1),
                                  itemCount: data.kategoriList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) =>
                                      AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 1200),
                                    child: ScaleAnimation(
                                      child: CategoryCard(
                                        onTap: () {
                                          setState(() {
                                            print("Tapped");
                                          });
                                        },
                                        kategori: data.kategoriList[index],
                                        selectedIndexKategori:
                                            data.selectedIndexKategori,
                                        indexList: index,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * .03,
                      ),
                      Expanded(
                        child: data.barangIsLoading
                            ? Center(
                                child: LoadingAnimationWidget.threeArchedCircle(
                                  color: Colors.purple,
                                  size: size.width * .1,
                                ),
                              )
                            : data.selectedIndexKategori == 0
                                ? AnimationLimiter(
                                    child: GridView.builder(
                                      controller: gridViewScroll,
                                      padding: EdgeInsets.only(
                                          bottom: size.width * .16),
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 9 / 12,
                                        crossAxisCount:
                                            3, // number of items in each row
                                        mainAxisSpacing:
                                            11, // spacing between rows
                                        crossAxisSpacing:
                                            11, // spacing between columns
                                      ),
                                      itemCount: data.listOfAllBarang
                                          .length, // total number of items
                                      itemBuilder: (context, index) {
                                        var barang = data.listOfAllBarang;
                                        var resultTable =
                                            data.listOfTableOrder.indexWhere(
                                          (element) {
                                            return element.kdBrg ==
                                                barang[index].kdBrg;
                                          },
                                        );

                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration: const Duration(
                                            milliseconds: 1400,
                                          ),
                                          columnCount: 3,
                                          child: ScaleAnimation(
                                            child: ProductMenuCard(
                                              barang: barang[index],
                                              isSelected: resultTable == -1
                                                  ? false
                                                  : true,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : AnimationLimiter(
                                    child: GridView.builder(
                                      controller: gridViewScroll,
                                      padding: EdgeInsets.only(
                                          bottom: size.width * .16),
                                      physics: const BouncingScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 9 / 12,
                                        crossAxisCount:
                                            3, // number of items in each row
                                        mainAxisSpacing:
                                            11, // spacing between rows
                                        crossAxisSpacing:
                                            11, // spacing between columns
                                      ),
                                      itemCount: data.listOfKategoriBarang
                                          .length, // total number of items
                                      itemBuilder: (context, index) {
                                        var barang = data.listOfKategoriBarang;
                                        var resultTable =
                                            data.listOfTableOrder.indexWhere(
                                          (element) {
                                            return element.kdBrg ==
                                                barang[index].kdBrg;
                                          },
                                        );
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration: const Duration(
                                              milliseconds: 1400),
                                          columnCount: 3,
                                          child: ScaleAnimation(
                                            child: ProductMenuCard(
                                              barang: barang[index],
                                              isSelected: resultTable == -1
                                                  ? false
                                                  : true,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideInRight(
        duration: const Duration(milliseconds: 1200),
        child: FadeIn(
          duration: const Duration(milliseconds: 1600),
          child: SizedBox(
            height: size.width * .1,
            width: Provider.of<BarangProvider>(context).listOfTableOrder.isEmpty
                ? size.width * .2
                : size.width,
            child: Provider.of<BarangProvider>(context).listOfTableOrder.isEmpty
                ? MainButton(
                    isOutlined: true,
                    label: 'Kembali',
                    onTap: () => Navigator.pop(context),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * .1,
                      ),
                      MainButton(
                        isOutlined: true,
                        label: "Batal",
                        onTap: () =>
                            Provider.of<BarangProvider>(context, listen: false)
                                .resetOrder(),
                      ),
                      SizedBox(
                        width: size.width * .06,
                      ),
                      MainButton(
                        isOutlined: false,
                        label: 'Lihat Pesanan',
                        onTap: () {
                          return Navigator.push(
                            context,
                            PageTransition(
                              child: const OrderMenuScreen(),
                              duration: const Duration(milliseconds: 1000),
                              reverseDuration:
                                  const Duration(milliseconds: 800),
                              type: PageTransitionType.bottomToTop,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  final List bannernya = [
    AppAssets().banner1,
    AppAssets().banner2,
    AppAssets().banner3,
    AppAssets().banner4
  ];
}
