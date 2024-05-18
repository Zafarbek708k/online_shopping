import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../service/http_client_cervice.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  List<Products> products = [];
  List<Products>? result = [];
  String? selectedCategory;

  TextEditingController passwordController = TextEditingController();

  Future<String?> readProducts() async {
    String? result =
        await HttpClientService.getData(api: HttpClientService.baseApiGet);
    log(result.toString());
    if (result != null) {
      setState(() {
        log(isLoading.toString());
      });
      products = productsFromJson(result);
      log(products[1].title.toString());
    } else {
      log("don't come to data");
    }
  }

  void searchProduct(String text) {
    if (text.isEmpty) {
      isLoading = false;
    } else {
      result = products
          .where((element) => element.title!.toLowerCase().contains(text))
          .toList();
      isLoading = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    readProducts().then((value) {
      searchProduct('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Category types ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),

                DropdownButton<String>(
                  borderRadius: BorderRadius.circular(15),
                  value: selectedCategory,
                  hint: const Text('Category'),
                  items: const [
                    DropdownMenuItem(value: 'smartphones', child: Text("Smartphones")),
                    DropdownMenuItem(value: 'laptops', child: Text("Laptops")),
                    DropdownMenuItem(value: 'fragrances', child: Text("Fragrances")),
                    DropdownMenuItem(value: 'skincare', child: Text("Skincare")),
                    DropdownMenuItem(value: 'groceries', child: Text("Groceries")),
                    DropdownMenuItem(value: 'decoration', child: Text("Decoration")),
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                searchProduct(value);
              },
              decoration: InputDecoration(
                labelText: 'Searching',
                hintText: 'e.g., Iphone',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.shade700),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            isLoading
                ? Expanded(
                    child: ListView.builder(
                      itemCount: result?.length,
                      itemBuilder: (context, index) {
                        Products product = result![index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              product.thumbnail!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.title ?? ''),
                            subtitle:
                                Text('Price: \$${product.price.toString()}'),
                            onTap: () {
                              // Add any onTap logic here
                            },
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(child: SvgPicture.asset("assets/svg/search.svg"))
          ],
        ),
      ),
    );
  }
}


