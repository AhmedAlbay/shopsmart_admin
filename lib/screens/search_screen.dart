import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../services/assets_manager.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

import '../widgets/product_widget.dart';
import '../widgets/title_text.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitlesTextWidget(label: passedCategory ?? "Search"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: StreamBuilder<List<ProductModel>>(
            stream: productProvider.fetchProductStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: TitlesTextWidget(label: snapshot.hasError.toString()),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: TitlesTextWidget(label: "NO Product Added"),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: searchTextController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Search',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              // setState(() {
                              searchTextController.clear();
                              FocusScope.of(context).unfocus();
                              // });
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            )),
                      ),
                      onChanged: (value) {
                        setState(() {
                          productListSearch = productProvider.searchProduct(
                              searchText: searchTextController.text,
                              passedList: productListSearch);
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          productListSearch = productProvider.searchProduct(
                              searchText: searchTextController.text,
                              passedList: productListSearch);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (searchTextController.text.isNotEmpty &&
                        productListSearch.isEmpty) ...[
                      const Center(
                        child: TitlesTextWidget(
                          label: "No Result Found",
                          fontSize: 28,
                        ),
                      )
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                          itemCount: searchTextController.text.isNotEmpty
                              ? productListSearch.length
                              : productList.length,
                          builder: (context, index) {
                            return ProductWidget(
                                productId: searchTextController.text.isNotEmpty
                                    ? productListSearch[index].productId
                                    : productList[index].productId);
                          },
                          crossAxisCount: 2),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
