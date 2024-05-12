import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/product_model.dart';
import '../service/http_client_cervice.dart';

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  bool isLoading = false;
  List<Products> products = [];

  Future<String?> readProducts() async {
    isLoading = false;
    String? result =
    await HttpClientService.getData(api: HttpClientService.baseApiBasket);
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

  Future<String?>deleteData({required String id})async{
    String? result = await HttpClientService.deleteData( api: HttpClientService.baseApiBasket, id: id);
    if(result != null){
      log("successfully deleted");
      await readProducts();
      setState(() {
      });
      return result;
    }else{
      log("O'chmadiyu");
      return result.toString();
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
                      String? result = await deleteData(id: product.id!);
                      setState(() {

                      });
                      log(result.toString());
                    },
                    autoClose: true,
                    backgroundColor: const Color(0xFFE50C0C),
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outlined,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(20),
                  ),
                ],
              ),
              child: Card(
                child: ListTile(
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
