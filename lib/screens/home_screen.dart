import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin/providers/theme_provider.dart';
import 'package:shopsmart_admin/widgets/subtitle_text.dart';
import 'package:shopsmart_admin/widgets/title_text.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SubtitleTextWidget(
            label: "Hi again!",
            fontSize: 60,
            color: Colors.red,
          ),
          TitlesTextWidget(
            label: "This is a title" * 10,
            fontSize: 50,
            maxLines: 2,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Hello world"),
          ),
          SwitchListTile(
            title:
                Text(themeProvider.getIsDarkTheme ? "Dark mode" : "Light mode"),
            value: themeProvider.getIsDarkTheme,
            onChanged: (value) {
              themeProvider.setDarkTheme(themeValue: value);
            },
          ),
        ],
      ),
    );
  }
}
