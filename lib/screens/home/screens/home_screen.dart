import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:e_commerce_app/screens/account/screen/account_screen.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/category/screen/category_deals_screen.dart';
import 'package:e_commerce_app/screens/home/widgets/product_container.dart';
import 'package:e_commerce_app/screens/home/widgets/product_title.dart';
import 'package:e_commerce_app/screens/search/screens/search_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/dealofday_container.dart';
import '../widgets/slider_container_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getDealOfTheDayProducts(context);
    homeProvider.getNewArrivalProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 70,
              backgroundColor: GlobalVariables.backgroundColor,
              title: const Text(
                "IShopTech",
                style: TextStyle(
                  color: GlobalVariables.primaryColor,
                  fontSize: 22,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AccountScreen.routeName);
                  },
                  child: const ImageIcon(
                    AssetImage(
                      'assets/icons/user.png',
                    ),
                    color: GlobalVariables.blackColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  },
                  child: Stack(
                    children: [
                      const ImageIcon(
                        AssetImage(
                          'assets/icons/cart.png',
                        ),
                        color: GlobalVariables.blackColor,
                        size: 50,
                      ),
                      Positioned(
                        right: 5,
                        top: 2,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 8,
                          child: Center(
                            child: Text(
                              user.cart == null
                                  ? '0'
                                  : user.cart!.length.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Dimensions.kWidth10
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(left: 10),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: GlobalVariables.backgroundColor,
                          border: Border.all(
                              color: const Color.fromARGB(255, 200, 200, 200),
                              width: 0.7),
                          borderRadius: Dimensions.kRadius10),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Search your products",
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(Icons.search)
                          ],
                        ),
                      )),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CarouselSlider.builder(
                    itemCount: GlobalVariables.carouselImages.length,
                    itemBuilder: (context, index, _) {
                      return SliderContainerWidget(
                        imageUrl: GlobalVariables.carouselImages[index],
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      viewportFraction: 0.95,
                    ),
                  ),
                  const productTitleWidget(
                    label: "Categories",
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Center(
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const PageScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: GlobalVariables.productCategory.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CategoryDealsScreen.routeName,
                                    arguments: GlobalVariables
                                        .productCategory[index]['title']
                                        .toString());
                              },
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color:
                                            GlobalVariables.primaryLightColor,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: Offset(0, 6),
                                          ),
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Colors.grey,
                                            offset: Offset(-1, 0),
                                          ),
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.grey,
                                            offset: Offset(2, 0),
                                          )
                                        ],
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          image: DecorationImage(
                                            image: AssetImage(GlobalVariables
                                                .productCategory[index]['image']
                                                .toString()),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Dimensions.kHeight10,
                                    Text(
                                      GlobalVariables.productCategory[index]
                                              ['title']
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  const productTitleWidget(
                    label: "Best Deals",
                  ),
                  Consumer<HomeProvider>(
                    builder: (context,homeProvider,child) {
                      return homeProvider.isLoading
                          ? const ProductContainerShimmer()
                          : SizedBox(
                              height: 240,
                              child: ListView.builder(
                                  itemCount: homeProvider.dealOfTheDay!.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ProductContainerWidget(
                                      product: homeProvider.dealOfTheDay![index],
                                    );
                                  }),
                            );
                    }
                  ),
                  const productTitleWidget(label: "Deal Of The Day"),
                 Consumer<HomeProvider>(
                   builder: (context,homeProvider,child) {
                     return homeProvider.isLoading
                          ? const DealOfTheDayContainerShimmer()
                          : DealOfTheDayContainer(
                              product: homeProvider.dealOfTheDay![0],
                            );
                   }
                 ),
                  const productTitleWidget(label: "New Arrivals"),
                  Consumer<HomeProvider>(
                    builder: (context,homeProvider,child) {
                      return homeProvider.isLoading
                          ? const ProductContainerShimmer()
                          : Container(
                              height: 240,
                              color: Colors.white,
                              child: ListView.builder(
                                  itemCount: homeProvider.newArrival!.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ProductContainerWidget(
                                      product: homeProvider.newArrival![index],
                                    );
                                  }),
                            );
                    }
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGdhZGdldHxlbnwwfDB8MHx8fDA%3D"),
                            fit: BoxFit.cover)),
                  ),
                  // productTitleWidget(),
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
