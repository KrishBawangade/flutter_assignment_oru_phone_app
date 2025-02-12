import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_oru_phone_app/models/product_model.dart';
import 'package:flutter_assignment_oru_phone_app/models/user_model.dart';
import 'package:flutter_assignment_oru_phone_app/providers/general_api_provider.dart';
import 'package:flutter_assignment_oru_phone_app/providers/user_auth_provider.dart';
import 'package:flutter_assignment_oru_phone_app/utils/constants.dart';
import 'package:provider/provider.dart';

class ProductSingleItem extends StatelessWidget {
  final Product product;

  const ProductSingleItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    UserAuthProvider authProvider = Provider.of(context);
    GeneralApiProvider generalProvider = Provider.of(context);
    UserModel? userData = authProvider.userData;
    bool isFavorite = (userData?.favListings??[]).contains(product.listingId);
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                        child: CachedNetworkImage(
                          alignment: Alignment.topCenter,
                          imageUrl: product.defaultImage?.fullImage ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(product.marketingName ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis)),
                            Text(
                "${product.deviceRam ?? ""}/${product.deviceStorage}•${product.deviceCondition}",
                style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold,)),
                            Text("₹ ${product.listingPrice}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: AppConstants.poppinsFontFamily)),
                          ]),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(60),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                            "${product.listingLocality ?? ""}, ${product.listingLocation ?? ""}, ${product.listingState ?? ""}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis))),
                    SizedBox(width: 16),
                    Expanded(
                        flex: 1,
                        child: Text(product.listingDate ?? "",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis)))
                  ]),
                ))
          ])),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () async{
                      generalProvider.likeProduct(product.listingId!, !isFavorite);
                    }, icon: Icon(isFavorite? Icons.favorite: Icons.favorite_outline, color: isFavorite?Colors.red: Colors.white)),
                  ],
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}
