import 'dart:async';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/home_provider.dart';
import 'package:e_commerce_app/screens/home/widgets/best_deal_listview_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/bottom_banner.dart';
import 'package:e_commerce_app/screens/home/widgets/category_grid_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/dealoftheday_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/newarrival_listview_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/product_title.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/home/widgets/sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../widgets/banner_slider_widget.dart';
import '../widgets/paged_productcontainer_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);

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

  List<Widget> homeWidgets = [
    const HomeBannerSlider(),
    const ProductTitleWidget(label: "Categories"),
    const CategoryGrid(),
    const ProductTitleWidget(label: "Best Deals"),
    const BestDealListView(),
    const ProductTitleWidget(label: "Deal Of The Day"),
    const DealOfTheDayWidget(),
    const ProductTitleWidget(label: "New Arrivals"),
    const NewArrivalListView(),
    const BottomBanner(),
    // const ProductTitleWidget(label: "All Items"),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: CustomScrollView(
        slivers: [ 
          HomeSliverAppBar(user: user),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: homeWidgets.length,
              (context, index) => homeWidgets[index],
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
                return PagedProductContainer(avgRating: avgRating, item: item);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
