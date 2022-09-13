import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product.dart';

class UserProductsScreen extends StatefulWidget {
  static const routeName = '/user-products';

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {

              Navigator.of(context).pushNamed(EditProductScreen.routeName);

            },
          )
        ],
      ),
      drawer: AppDrawer(),

      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                    productsData.items[index].title,
                    productsData.items[index].imageUrl,
                    productsData.items[index].id,


                ),
                Divider(),
              ],
            )),
      ),
    );
  }
}