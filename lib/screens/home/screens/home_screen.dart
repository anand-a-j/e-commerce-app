import 'dart:async';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:e_commerce_app/screens/account/screen/account_screen.dart';
import 'package:e_commerce_app/screens/cart/screen/cart_screen.dart';
import 'package:e_commerce_app/screens/home/widgets/best_deal_listview_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/category_grid_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/product_container.dart';
import 'package:e_commerce_app/screens/home/widgets/product_title.dart';
import 'package:e_commerce_app/screens/home/widgets/search_bar.dart';
import 'package:e_commerce_app/screens/product_details/screens/product_details_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/utils/dimensions.dart';
import 'package:e_commerce_app/utils/global_variables.dart';
import 'package:e_commerce_app/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../widgets/banner_slider_widget.dart';
import '../widgets/dealofday_container.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);

  // List<ProductModel>? nextPageData;

  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getNewArrivalProducts(context);
    homeProvider.getDealOfTheDayProducts(context);
    _pagingController.addPageRequestListener((pageKey) {
      fetchNextPage(pageKey);
    });
    super.initState();
  }

  Future<void> fetchNextPage(int pageKey) async {
    try {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getDealOfTheDayProducts(context);

      Timer(const Duration(seconds: 2), () {
        if (homeProvider.dealOfTheDay.isEmpty) {
          _pagingController.appendPage(homeProvider.dealOfTheDay, pageKey + 1);
        } else {
          _pagingController.appendLastPage(homeProvider.dealOfTheDay);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: HomeSearchBar(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const HomeBannerSlider(),
                  const productTitleWidget(label: "Categories"),
                  const CategoryGrid(),
                  const productTitleWidget(label: "Best Deals"),
                  const BestDealListView(),
                  const productTitleWidget(label: "Deal Of The Day"),
                  Consumer<HomeProvider>(
                      builder: (context, homeProvider, child) {
                    return homeProvider.isLoading
                        ? const DealOfTheDayContainerShimmer()
                        : DealOfTheDayContainer(
                            product: homeProvider.dealOfTheDay[0],
                          );
                  }),
                  const productTitleWidget(label: "New Arrivals"),
                  Consumer<HomeProvider>(
                      builder: (context, homeProvider, child) {
                    return homeProvider.isLoading
                        ? const ProductContainerShimmer()
                        : Container(
                            height: 240,
                            color: Colors.white,
                            child: ListView.builder(
                                reverse: true,
                                itemCount: homeProvider.newArrival.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ProductContainerWidget(
                                    product: homeProvider.newArrival[index],
                                  );
                                }),
                          );
                  }),
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
                  const productTitleWidget(label: "All Items"),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: PagedListView<int, ProductModel>(
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                    itemBuilder: (context, item, index) {
                  double avgRating = 0;
                  double totalRating = 0;
                  for (int i = 0; i < item.rating!.length; i++) {
                    totalRating += item.rating![i].rating;
                  }

                  if (totalRating != 0) {
                    avgRating = totalRating / item.rating!.length;
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ProductDetailsScreen.routeName,
                          arguments: item);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                borderRadius: BorderRadius.circular(15),
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
                                image: DecorationImage(
                                    image: NetworkImage(item.images[0]),
                                    fit: BoxFit.cover)),
                          ),
                          Dimensions.kWidth20,
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Dimensions.kHeight10,
                                RatingStars(rating: avgRating),
                                Dimensions.kHeight10,
                                Text(
                                  '₹ ${item.price}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

