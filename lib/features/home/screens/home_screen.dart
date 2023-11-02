import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/features/home/services/home_services.dart';
import 'package:e_commerce_app/features/home/widgets/product_container.dart';
import 'package:e_commerce_app/features/home/widgets/product_title.dart';
import 'package:e_commerce_app/features/search/screens/search_screen.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/dealofday_container.dart';
import '../widgets/slider_container_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeServices homeServices = HomeServices();
  List<ProductModel>? dealOfTheDay;

  @override
  void initState() {
    getDealOfTheDayProducts();
    super.initState();
  }

  void getDealOfTheDayProducts() async {
    dealOfTheDay =
        await homeServices.fetchDealOfTheDayProduct(context: context);
    setState(() {});
  }

  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    // TextEditingController searchController = TextEditingController();
    print("User ; $user");
    return Scaffold(
      // appBar: AppBar(
      //   title: Container(
      //     width: double.infinity,
      //     height: 40,
      //     decoration: BoxDecoration(
      //         color: Colors.white,
      //         border: Border.all(
      //           color: Colors.grey,
      //           width: 0.8,
      //         ),
      //         borderRadius: BorderRadius.circular(10)),
      //     child: TextField(
      //       // controller: searchController,
      //       decoration: const InputDecoration(hintText: "Search products here"),
      //       onSubmitted: navigateToSearchScreen,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: GlobalVariables.backgroundColor,
              title: Text(
                "E Commerce App",
                style: TextStyle(color: Colors.black),
              ),
              actions: const [
                ImageIcon(
                  AssetImage(
                    'assets/icons/user.png',
                  ),
                  color: GlobalVariables.blackColor,
                ),
                Dimensions.kWidth10,
                ImageIcon(
                  AssetImage(
                    'assets/icons/cart.png',
                  ),
                  color: GlobalVariables.blackColor,
                ),
                Dimensions.kWidth10
              ],
              bottom: AppBar(
                backgroundColor: GlobalVariables.backgroundColor,
                title: Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      color: GlobalVariables.backgroundColor,
                      border: Border.all(
                          color: Color.fromARGB(255, 122, 122, 122),
                          width: 0.8),
                      borderRadius: Dimensions.kRadius10),
                  child: TextField(
                    // controller: searchController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search products here",
                      border: InputBorder.none,
                    ),
                    onSubmitted: navigateToSearchScreen,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CarouselSlider.builder(
                    itemCount: GlobalVariables.carouselImages.length,
                    itemBuilder: (context, index, _) {
                      return SliderContainerWidget();
                    },
                    options: CarouselOptions(
                      // height: 180.0,
                      //  enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      viewportFraction: 0.95,
                    ),
                  ),
                  productTitleWidget(),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Center(
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: PageScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.purple.shade50,
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: NetworkImage(GlobalVariables
                                              .carouselImages[index]),
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Dimensions.kHeight10,
                                  Text(GlobalVariables.categoryImages[index]
                                          ['title']
                                      .toString())
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: GlobalVariables.categoryImages.length,
                  //       itemBuilder: (context, index) {
                  //         return GestureDetector(
                  //             onTap: () {
                  //               Navigator.pushNamed(
                  //                   context, CategoryDealsScreen.routeName,
                  //                   arguments: GlobalVariables
                  //                       .categoryImages[index]['title']
                  //                       .toString());
                  //             },
                  //             child: Chip(
                  //                 label: Text(GlobalVariables
                  //                     .categoryImages[index]['title']
                  //                     .toString())));
                  //       }),
                  // ),
                  productTitleWidget(),
                  dealOfTheDay == null
                      ? const ProductContainerShimmer()
                      : Container(
                          height: 240,
                          child: ListView.builder(
                              itemCount: dealOfTheDay!.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductContainerWidget(
                                  product: dealOfTheDay![index],
                                );
                              }),
                        ),
                  productTitleWidget(),
                  dealOfTheDay == null
                      ? const DealOfTheDayContainerShimmer()
                      : DealOfTheDayContainer(
                          product: dealOfTheDay![0],
                        ),
                  productTitleWidget(),
                  Container(
                    height: 240,
                    color: Colors.white,
                    child: ListView.builder(
                        itemCount: dealOfTheDay!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductContainerWidget(
                            product: dealOfTheDay![index],
                          );
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhZGdldHxlbnwwfDB8MHx8fDA%3D"),
                            fit: BoxFit.cover)),
                  ),
                  productTitleWidget(),
                ],
              ),
            ),
            // PagedListView<int, int>(
            //   pagingController: _pagingController,
            //   builderDelegate: PagedChildBuilderDelegate<int>(
            //     itemBuilder: (context, item, index) {
            //       return ListTile(
            //         title: Text(numbers[index].toString()),
            //         subtitle: Text(numbers[index].toString()),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
