import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/drawer_item_model.dart';
import 'package:flutter_assignment_oru_phone_app/models/user_model.dart';
import 'package:flutter_assignment_oru_phone_app/pages/login_otp_page.dart';
import 'package:flutter_assignment_oru_phone_app/pages/splash_screen.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/colors.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActionItemModel {
  final String iconPath;
  final String title;

  ActionItemModel({required this.iconPath, required this.title});
}

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});

String convertDateFormat(String dateStr, String inputFormat, String outputFormat) {
  try {
    DateTime parsedDate = DateFormat(inputFormat).parse(dateStr); // Parse input date
    String formattedDate = DateFormat(outputFormat).format(parsedDate); // Convert to new format
    return formattedDate;
  } catch (e) {
    return 'Invalid date format'; // Handle errors gracefully
  }
}

void main() {
  String dateStr = "2025-02-12"; // Example input date
  String newFormat = convertDateFormat(dateStr, "yyyy-MM-dd", "dd/MM/yyyy"); // Convert format
  print(newFormat); // Output: 12/02/2025
}


  @override
  Widget build(BuildContext context) {
    UserAuthProvider authProvider = Provider.of(context);
    UserModel? userData = authProvider.userData;
    List<DrawerItemModel> drawerItemList = [
      DrawerItemModel(
          title: "Log Out", icon: Icons.logout, onClick: (context) async{
            await authProvider.logout();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SplashScreen()));
          }),
    ];
    List<ActionItemModel> actionItemList = [
      ActionItemModel(iconPath: AppConstants.buySvgPath, title: "How to buy"),
      ActionItemModel(iconPath: AppConstants.sellSvgPath, title: "How to sell"),
      ActionItemModel(iconPath: AppConstants.faqSvgPath, title: "FAQs"),
      ActionItemModel(iconPath: AppConstants.aboutSvgPath, title: "About Us"),
      ActionItemModel(
          iconPath: AppConstants.privacyPolicySvgPath, title: "Privacy Policy"),
      ActionItemModel(
          iconPath: AppConstants.returnPolicySvgPath, title: "Return Policy"),
    ];

    String formattedDate = userData?.createdDate??"";

    if(formattedDate.isNotEmpty){
      formattedDate= convertDateFormat(formattedDate, "dd/MM/yyyy", "MMM dd yyyy");
    }

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            authProvider.csrfToken == null
                ? Container(
                  color: Theme.of(context).hintColor.withAlpha(30),
                  child: Padding(
                    padding: const EdgeInsets.only(
                                  left: 16, right: 8, top: 0, bottom: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Image.asset(AppConstants.oruPhoneLogoImagePath,
                                width: 50, height: 50),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.close, size: 30))
                          ]),
                  ),
                )
                : DrawerHeader(
                    decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withAlpha(30)),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 8, top: 0, bottom: 0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                      AppConstants.oruPhoneLogoImagePath,
                                      width: 50,
                                      height: 50),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.close, size: 30))
                                ]),
                          ),
                          ListTile(
                            title: Text(userData!.userName.isEmpty?"N/A": userData.userName,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Joined: $formattedDate",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withAlpha(80),
                                    fontWeight: FontWeight.w700)),
                            leading: Icon(Icons.account_circle, size: 50),
                          )
                        ],
                      ),
                    )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    authProvider.csrfToken == null
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginOtpPage()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.colorPrimary,
                                            foregroundColor: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text("Login/Signup",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          )
                        : SizedBox.shrink(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.colorSecondary,
                                  foregroundColor: AppColors.colorOnSecondary),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("Sell Your Phone",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          authProvider.csrfToken != null
                              ? Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: drawerItemList.length,
                                        itemBuilder: (context, index) {
                                          var drawerItem =
                                              drawerItemList[index];
                                          return ListTile(
                                              onTap: () {
                                                if (drawerItem.onClick !=
                                                    null) {
                                                  drawerItem.onClick!(context);
                                                } else {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              drawerItem
                                                                  .pageWidget!));
                                                }
                                              },
                                              title: Text(drawerItem.title),
                                              leading: Icon(drawerItem.icon));
                                        }),
                                    const SizedBox(height: 16),
                                  ],
                                )
                              : SizedBox.shrink(),
                          GridView.extent(
                            shrinkWrap: true,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 78 / 50,
                            children: actionItemList.map((actionItem) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withAlpha(40)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(actionItem.iconPath,
                                            width: 20, height: 20),
                                        SizedBox(height: 4),
                                        Text(
                                          actionItem.title,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ]),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
