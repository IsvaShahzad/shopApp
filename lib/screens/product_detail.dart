import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  // final String title;
  //
  // DetailScreen(this.title);

  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; //is the id
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findbyId(productId);

    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),

              ),

              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '\$${loadedProduct.price}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
                  ),
            ],
          ),
        ));
  }
}
