import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/product_model.dart';
import 'package:flutter_assignment_oru_phone_app/pages/home_page/widgets/product_single_item.dart';
import 'package:flutter_assignment_oru_phone_app/pages/login_otp_page.dart';
import 'package:flutter_assignment_oru_phone_app/providers/filter_sort_provider.dart';
import 'package:flutter_assignment_oru_phone_app/providers/general_api_provider.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/colors.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:flutter_assignment_oru_phone_app/widgets/main_app_drawer.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ActionChipItemModel {
  final String title;
  final String? iconPath;
  final Function()? onClick;

  ActionChipItemModel({required this.title, this.onClick, this.iconPath});
}

class WhatsInYourMindItemModel {
  final String title;
  final String iconPath;
  final Function()? onClick;

  WhatsInYourMindItemModel(
      {required this.title, this.onClick, required this.iconPath});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final StickyHeaderController _stickyHeaderController =
      StickyHeaderController();
  final TextEditingController _searchController = TextEditingController();
  final List<ActionChipItemModel> actionChipItemList = [
    ActionChipItemModel(title: "Sell Used Phones"),
    ActionChipItemModel(title: "Buy Used Phones"),
    ActionChipItemModel(title: "Compare Prices"),
    ActionChipItemModel(title: "My Profile"),
    ActionChipItemModel(title: "My Listings"),
    ActionChipItemModel(title: "Services"),
    ActionChipItemModel(
        title: "Register Your Store", iconPath: AppConstants.newSvgPath),
    ActionChipItemModel(title: "Get the App"),
  ];

  final carouselImagePathList = [
    AppConstants.banner1ImagePath,
    AppConstants.banner2ImagPath,
    AppConstants.banner3ImagePath,
    AppConstants.banner4ImagePath,
    AppConstants.banner5ImagePath,
  ];

  final whatsInYourMindItemList = [
    WhatsInYourMindItemModel(
        title: "Buy Used Phones", iconPath: AppConstants.mind1ImagePath),
    WhatsInYourMindItemModel(
        title: "Sell Used Phones", iconPath: AppConstants.mind2ImagePath),
    WhatsInYourMindItemModel(
        title: "Compare Prices", iconPath: AppConstants.mind3ImagePath),
    WhatsInYourMindItemModel(
        title: "My Profile", iconPath: AppConstants.mind4ImagePath),
    WhatsInYourMindItemModel(
        title: "My Listings", iconPath: AppConstants.mind5ImagePath),
    WhatsInYourMindItemModel(
        title: "Open Store", iconPath: AppConstants.mind6ImagePath),
    WhatsInYourMindItemModel(
        title: "Services", iconPath: AppConstants.mind7ImagePath),
    WhatsInYourMindItemModel(
        title: "Device Health Check", iconPath: AppConstants.mind8ImagePath),
    WhatsInYourMindItemModel(
        title: "Battery Health Check", iconPath: AppConstants.mind9ImagePath),
    WhatsInYourMindItemModel(
        title: "IMEI Verification", iconPath: AppConstants.mind10ImagePath),
    WhatsInYourMindItemModel(
        title: "Device Details", iconPath: AppConstants.mind11ImagePath),
    WhatsInYourMindItemModel(
        title: "Data Wipe", iconPath: AppConstants.mind12ImagePath),
    WhatsInYourMindItemModel(
        title: "Under Warranty Phones", iconPath: AppConstants.mind13ImagePath),
    WhatsInYourMindItemModel(
        title: "Premium Phones", iconPath: AppConstants.mind14ImagePath),
    WhatsInYourMindItemModel(
        title: "Like New Phones", iconPath: AppConstants.mind15ImagePath),
    WhatsInYourMindItemModel(
        title: "Refurbished Phones", iconPath: AppConstants.mind16ImagePath),
    WhatsInYourMindItemModel(
        title: "Verified Phones", iconPath: AppConstants.mind17ImagePath),
    WhatsInYourMindItemModel(
        title: "My Negotiations", iconPath: AppConstants.mind18ImagePath),
    WhatsInYourMindItemModel(
        title: "My Favourites", iconPath: AppConstants.mind19ImagePath),
  ];

  int _currentIndex = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    GeneralApiProvider generalProvider = Provider.of(context, listen: false);
    FilterSortProvider filterSortProvider = Provider.of(context, listen: false);
    await generalProvider.fetchBrands();
    await generalProvider.fetchFaqs();
    await filterSortProvider.fetchFilteredProducts();
    var list = filterSortProvider.filteredProducts;
    bool changed = false;
    for (int i = 0; i < list.length; i++) {
      if ((i + 1) % 7 == 0) {
        list.insert(i + 1, Product());
        changed = true;
      }
    }
    if (changed) {
      filterSortProvider.setFilteredProducts(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserAuthProvider authProvider = Provider.of(context);
    GeneralApiProvider generalProvider = Provider.of(context);
    FilterSortProvider filterSortProvider = Provider.of(context);

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: MainAppDrawer(onClose: (){
          scaffoldKey.currentState?.closeDrawer();  
        },),
        body: CustomScrollView(
          slivers: [
            // SliverAppBar: This is the scrollable AppBar
            SliverAppBar(
              floating: true, // AppBar is not floating
              pinned: false, // AppBar stays pinned at the top when scrolling
              snap:
                  false, // Doesn't snap to fully expanded when scrolling quickly,
              forceMaterialTransparency: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Text("India",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(width: 4),
                    Icon(Icons.place_outlined, size: 30)
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 16),
                  child: authProvider.csrfToken == null
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => LoginOtpPage()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.colorSecondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          child: Text("Login",
                              style: TextStyle(
                                  color: AppColors.colorOnSecondary,
                                  fontWeight: FontWeight.bold)))
                      : Icon(Icons.notifications_outlined, size: 30),
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16, right: 8, left: 24),
                child: InkWell(
                  onTap: (){
                    scaffoldKey.currentState?.openDrawer(); // Open drawer
                  },
                  child: SvgPicture.asset(AppConstants.drawerSvgPath,
                      width: 10, height: 10),
                ),
              ),
              flexibleSpace: Stack(
                children: [
                  // Apply the blur effect
                  Positioned.fill(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 10.0, sigmaY: 10.0), // Blur effect
                        child: Container(
                          color: Colors.white
                              .withAlpha(50), // Semi-transparent overlay
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // AppBar content
              title: Image.asset(AppConstants.oruPhoneLogoImagePath,
                  width: 50, height: 50),
              elevation: 0, // Remove shadow
            ),
            SliverStickyHeader.builder(
                controller: _stickyHeaderController,
                builder: (context, state) {
                  return ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            children: [
                              TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText:
                                          "Search phones with make, model, company...",
                                      hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withAlpha(100),
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.search,
                                            color: AppColors.colorSecondary),
                                      ),
                                      suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(width: 8),
                                            // Vertical Line
                                            Container(
                                              width: 1.2, // Line Width
                                              height: 18, // Line Height
                                              color: Colors.grey, // Line Color
                                            ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child:
                                                  Icon(Icons.mic_none_outlined),
                                            )
                                          ]))),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 50,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: actionChipItemList.map((chipItem) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ActionChip(
                                        label: Text(chipItem.title),
                                        avatar: chipItem.iconPath != null
                                            ? SvgPicture.asset(
                                                chipItem.iconPath!)
                                            : null,
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          if (chipItem.onClick != null) {
                                            chipItem.onClick!();
                                          }
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, top: 8, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 200.0, // Height of the carousel
                                viewportFraction: 1,
                                autoPlay: true, // Enables automatic movement
                                autoPlayInterval:
                                    Duration(seconds: 5), // Time interval
                                autoPlayAnimationDuration: Duration(
                                    milliseconds: 800), // Animation speed
                                enlargeCenterPage:
                                    true, // Zoom effect on center item
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndex = index; // Track active index
                                  });
                                },
                              ),
                              items: carouselImagePathList.map((imagePath) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    imagePath,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),

                            // Indicator Dots
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: carouselImagePathList
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey),
                                    color: _currentIndex == entry.key
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("What's on your mind?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      fontFamily:
                                          AppConstants.poppinsFontFamily)),
                              SizedBox(
                                height: 200,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children:
                                        whatsInYourMindItemList.map((item) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8, right: 16),
                                        child: InkWell(
                                          onTap: () {
                                            if (item.onClick != null) {
                                              item.onClick!();
                                            }
                                          },
                                          child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: Column(children: [
                                              Image.asset(item.iconPath),
                                              SizedBox(height: 4),
                                              Text(item.title,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ]),
                                          ),
                                        ),
                                      );
                                    }).toList()),
                              )
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Top Brands",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            fontFamily: AppConstants
                                                .poppinsFontFamily)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.arrow_forward_ios,
                                            color: Colors.grey)),
                                  ]),
                              SizedBox(
                                height: 100,
                                child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    children: (generalProvider.brands.length > 7
                                            ? generalProvider.brands
                                                .sublist(0, 8)
                                            : generalProvider.brands)
                                        .map((brand) {
                                      int index =
                                          generalProvider.brands.indexOf(brand);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: index != 7
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CachedNetworkImage(
                                                        imageUrl:
                                                            brand.imagePath,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.center,
                                                        width: 50,
                                                        height: 50),
                                                  )
                                                : Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                        Text("View All",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        const SizedBox(
                                                            width: 4),
                                                        Icon(
                                                            Icons.arrow_forward,
                                                            size: 15)
                                                      ]),
                                          ),
                                        ),
                                      );
                                    }).toList()),
                              )
                            ]),
                        SizedBox(height: 24),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Best deals ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily:
                                            AppConstants.poppinsFontFamily)),
                                TextSpan(
                                    text: "in India",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontFamily:
                                            AppConstants.poppinsFontFamily))
                              ])),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  ActionChip(
                                      backgroundColor: Colors.white,
                                      onPressed: () {},
                                      avatar: Icon(Icons.swap_vert),
                                      label: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Sort"),
                                            SizedBox(width: 4),
                                            Icon(Icons.keyboard_arrow_down)
                                          ])),
                                  SizedBox(width: 8),
                                  ActionChip(
                                      backgroundColor: Colors.white,
                                      onPressed: () {},
                                      avatar: Icon(Icons.tune),
                                      label: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("filter"),
                                            SizedBox(width: 4),
                                            Icon(Icons.keyboard_arrow_down)
                                          ])),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GridView.extent(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 0.6,
                                  children: filterSortProvider.filteredProducts
                                      .map((product) {
                                    int index = filterSortProvider
                                        .filteredProducts
                                        .indexOf(product);
                                    return product.id?.isEmpty ?? true
                                        ? (index / 7) % 2 != 0
                                            ? Image.asset(
                                                AppConstants.random1ImagePath)
                                            : Image.asset(
                                                AppConstants.random2ImagePath)
                                        : ProductSingleItem(
                                            product: product,
                                          );
                                  }).toList())
                            ]),
                        SizedBox(height: 16),
                        Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Frequently Asked Questions",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily:
                                            AppConstants.poppinsFontFamily)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios,
                                        color: Colors.grey)),
                              ]),
                          SizedBox(height: 16),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: generalProvider.faqs.map((faq) {
                              return ExpansionTileTheme(
                                data: ExpansionTileThemeData(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey, width: 0.7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    collapsedShape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey, width: 0.7),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.grey.withAlpha(
                                        40), // Background color of the title area
                                    collapsedBackgroundColor:
                                        Colors.grey.withAlpha(40)),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: ExpansionTile(
                                    initiallyExpanded: _isExpanded,
                                    onExpansionChanged: (val) {
                                      _isExpanded = val;
                                      setState(() {});
                                    },
                                    trailing: Icon(Icons.add),
                                    title: Text(faq.question ?? "",
                                        softWrap: true,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    children: [
                                      Container(
                                        color: Colors
                                            .white, // Background color of the expanded content
                                        padding: const EdgeInsets.all(
                                            16.0), // Add padding
                                        child: Text(
                                          faq.answer ?? "",
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        ])
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
