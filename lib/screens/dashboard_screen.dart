import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin/models/dashboard_model.dart';
import 'package:shopsmart_admin/widgets/dashboard_button.dart';
import 'package:shopsmart_admin/widgets/title_text.dart';

import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(label: "Dashboard Screen"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
          actions: [
            IconButton(
              onPressed: () {
                themeProvider.setDarkTheme(
                    themeValue: !themeProvider.getIsDarkTheme);
              },
              icon: Icon(themeProvider.getIsDarkTheme
                  ? Icons.light_mode
                  : Icons.dark_mode),
            ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: List.generate(
              3,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DashBoardButton(
                        title: DashBoardButtonModel.dashBoardBtn(context)[index]
                            .title,
                        imagePath:
                            DashBoardButtonModel.dashBoardBtn(context)[index]
                                .imagePath,
                        onPressed: () {
                          DashBoardButtonModel.dashBoardBtn(context)[index]
                              .onPressed();
                        }),
                  )),
        ));
  }
}
