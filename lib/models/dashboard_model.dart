import 'package:flutter/material.dart';
import 'package:shopsmart_admin/screens/edit_or_upload_product.dart';
import 'package:shopsmart_admin/screens/inner_screens/orders/orders_screen.dart';
import 'package:shopsmart_admin/screens/search_screen.dart';
import 'package:shopsmart_admin/services/assets_manager.dart';

class DashBoardButtonModel {
  final String title, imagePath;
  final Function onPressed;

  DashBoardButtonModel({
    required this.title,
    required this.imagePath,
    required this.onPressed,
  });
  static List<DashBoardButtonModel> dashBoardBtn(BuildContext context) => [
        DashBoardButtonModel(
          title: 'Add a New Prdouct',
          imagePath: AssetsManager.cloud,
          onPressed: () {            Navigator.pushNamed(context, EditOrUploadProductScreen.routeName);
},
        ),
        DashBoardButtonModel(
          title: 'inspect All Product',
          imagePath: AssetsManager.shoppingCart,
          onPressed: () {
            Navigator.pushNamed(context, SearchScreen.routeName);
          },
        ),
        DashBoardButtonModel(
          title: 'View All Order',
          imagePath: AssetsManager.order,
          onPressed: () {
            Navigator.pushNamed(context, OrdersScreenFree.routeName);
          },
        ),
      ];
}
