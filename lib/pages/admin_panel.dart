import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_shopping/models/product_model.dart';

import '../service/http_client_cervice.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

// String? id;
//   String? title;
//   String? description;
//   int? price;
//   double? discountPercentage;
//   double? rating;
//   int? stock;
//   String? brand;
//   String? category;
//   String? thumbnail;
//   List<String>? images;

class _AdminPanelState extends State<AdminPanel> {
  Color background = const Color.fromRGBO(44, 60, 80, 1);
  TextEditingController titleController =  TextEditingController();
  TextEditingController descriptionController =  TextEditingController();
  TextEditingController priceController =  TextEditingController();
  TextEditingController categoryController =  TextEditingController();
  TextEditingController imagesController =  TextEditingController();

  Future<String?>postProductToMockApi({required Products product})async{
    String? result =  await HttpClientService.postData(api: HttpClientService.baseApiGet, data:  product.toJson());
    if(result != null){
      log("succesfully Posted");
    }else{
      log("HomeScreen post qilish ishlamadi");
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        backgroundColor: background,
        title: const Text("Admin", style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              txtField(hinText: 'Title', controller: titleController),
              txtField(hinText: 'Description', controller: descriptionController),
              txtField(hinText: 'price', controller: priceController),
              txtField(hinText: 'category', controller: categoryController),
              txtField(hinText: 'ImageUrl', controller: imagesController),

              const SizedBox(height: 50),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  height: MediaQuery.of(context).size.height *0.1,
                  minWidth: double.infinity,
                  color: background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  onPressed: ()async{

                    titleController.clear();
                    descriptionController.clear();
                    priceController.clear();
                    categoryController.clear();
                    imagesController.clear();

                    Products product = Products(
                        description: descriptionController.text,
                        price: int.tryParse(priceController.text.trim()),
                        category: categoryController.text,
                        title: titleController.text,
                      images: [imagesController.text.trim()],
                      brand: "Best",
                      discountPercentage: 45.2,
                      id: "2",
                      rating: 55,
                      stock: 55,
                      thumbnail: "thumbnail"
                    );

                    if(titleController.text.length>2 && categoryController.text.length>2){
                      String? result = await postProductToMockApi(product: product);
                      log(result.toString());
                    }else {
                      titleController.clear();
                      descriptionController.clear();
                      priceController.clear();
                      categoryController.clear();
                      imagesController.clear();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Incomplete Product Information'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Title: ${product.title ?? ''}'),
                                Text('Description: ${product.description ?? ''}'),
                                Text('Price: ${product.price ?? ''}'),
                                Text('Category: ${product.category ?? ''}'),
                                Text('Images: ${product.images ?? ''}'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      log("To'li qiymat bering");
                    }


                  },
                  child: Center(
                    child: Text("Post Product", style: TextStyle(color: Colors.white, fontSize: 24),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


Widget txtField({required String hinText, required TextEditingController controller}){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: controller,
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
          hintText: hinText,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        filled: true,
        fillColor: Colors.grey[600],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black
          )
        ),
      ),
    ),
  );
}
