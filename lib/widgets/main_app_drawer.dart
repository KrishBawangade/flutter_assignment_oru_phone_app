import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/drawer_item_model.dart';
import 'package:flutter_assignment_oru_phone_app/utils/colors.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:flutter_svg/svg.dart';


class ActionItemModel{
  final String iconPath;
  final String title;

  ActionItemModel({required this.iconPath, required this.title});
}

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});


  @override
  Widget build(BuildContext context) {
  List<DrawerItemModel> drawerItemList = [
    DrawerItemModel(title: "Log Out", icon: Icons.logout, onClick: (context){

    }),
  ];
  List<ActionItemModel> actionItemList = [
    ActionItemModel(iconPath: AppConstants.buySvgPath, title: "How to buy"),
    ActionItemModel(iconPath: AppConstants.sellSvgPath, title: "How to sell"),
    ActionItemModel(iconPath: AppConstants.faqSvgPath, title: "FAQs"),
    ActionItemModel(iconPath: AppConstants.aboutSvgPath, title: "About Us"),
    ActionItemModel(iconPath: AppConstants.privacyPolicySvgPath, title: "Privacy Policy"),
    ActionItemModel(iconPath: AppConstants.returnPolicySvgPath, title: "Return Policy"),
  ];
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withAlpha(30)
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8, top: 0, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(AppConstants.oruPhoneLogoImagePath, width: 50, height: 50),
                        IconButton(onPressed: (){}, icon: Icon(Icons.close, size: 30))
                      ]
                    ),
                  ),
                  ListTile(
                    title: Text("Krish Bawangade", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Joined: July 6 2024", style: TextStyle(color: Theme.of(context).hintColor.withAlpha(80), fontWeight: FontWeight.w700)),
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){}, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.colorSecondary,
                            foregroundColor: AppColors.colorOnSecondary
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Sell Your Phone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Expanded(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: drawerItemList.length,
                          itemBuilder: (context, index){
                            var drawerItem = drawerItemList[index];
                            return ListTile(
                              onTap: (){
                                if(drawerItem.onClick != null){
                                  drawerItem.onClick!(context);
                                }else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> drawerItem.pageWidget!));
                                }
                              },
                              title: Text(drawerItem.title),
                              leading: Icon(drawerItem.icon)
                            );
                          }
                        ),
                        const SizedBox(height: 16),
                        GridView.extent(
                          shrinkWrap: true,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          maxCrossAxisExtent: 100, 
                          childAspectRatio: 78/50,
                          children: actionItemList.map((actionItem){
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).hintColor.withAlpha(40)),
                              borderRadius: BorderRadius.circular(10),
                              ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(actionItem.iconPath, width: 20, height: 20),
                                  SizedBox(height: 4),
                                  Text(actionItem.title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),)
                                ]
                              ),
                            ),
                          );
                        }).toList(),)
                      ],
                    ),
                  )
                ],),
              ),
            )
          ],
        ),
      ),
    );
  }
}