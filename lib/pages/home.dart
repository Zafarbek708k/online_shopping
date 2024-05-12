import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:online_shopping/pages/detail_page.dart';
import 'package:online_shopping/service/http_client_cervice.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/product_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  List<Products> products = [];

  Future<String?> readProducts() async {
    isLoading = false;
    String? result =
        await HttpClientService.getData(api: HttpClientService.baseApiGet);
    log(result.toString());
    if (result != null) {
      setState(() {
        isLoading = true;
      });
      products = productsFromJson(result);
      log(products[1].title.toString());
    } else {
      log("don't come to data");
    }
  }

  Future<String?> postProductToMockApi({required Products product}) async {
    String? result = await HttpClientService.postData(
        api: HttpClientService.baseApiBasket, data: product.toJson());
    if (result != null) {
      log("succesfully Posted");
    } else {
      log("HomeScreen post qilish ishlamadi");
    }
  }

  @override
  void initState() {
    readProducts();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (contex, index) {
                  Products product = products[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context)async{
                            Products addProduct = Products(
                              title: product.title,
                                 category: product.category,
                                description: product.description,
                                price: product.price,
                                discountPercentage: product.discountPercentage,
                                id: product.id,
                                images: product.images,
                                rating: product.rating,
                                stock: product.stock,
                                thumbnail: product.thumbnail,
                                brand: product.brand
                            );
                            String? result = await postProductToMockApi(product: addProduct);
                            log(result.toString());
                          },
                          autoClose: true,
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.shopping_basket_outlined,
                          label: 'Basket',
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                    child: Card(
                      child: ListTile(
                        onLongPress: (){
                          Products addProduct = Products(
                              title: product.title,
                              category: product.category,
                              description: product.description,
                              price: product.price,
                              discountPercentage: product.discountPercentage,
                              id: product.id,
                              images: product.images,
                              rating: product.rating,
                              stock: product.stock,
                              thumbnail: product.thumbnail,
                              brand: product.brand
                          );

                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailProduct(products: product,)));
                        },
                        leading: Image.network(
                          product.thumbnail!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title ?? ''),
                        subtitle: Text('Price: \$${product.price.toString()}'),
                        onTap: () {
                          // Add any onTap logic here
                        },
                      ),
                    ),
                  );
                }),
          )
        : const Center(child: Text("data"));
  }
}
