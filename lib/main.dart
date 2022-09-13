import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import './screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/product_overview.dart';
import './screens/product_detail.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products.dart';
import './screens/edit_product.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(
        create: (context) =>  Products(),),

      ChangeNotifierProvider(
        create: (context) => Cart(),),
      ChangeNotifierProvider(
        create: (context) => Orders(),),
    ],
      // create: (context) => Products(),

      child:MaterialApp(


          title: 'MyShop',
          theme: ThemeData(

            primarySwatch: Colors.pink,
            // colorScheme: ColorScheme.fromSwatch().copyWith(
            //   secondary: const Color(0xFFFFC0CB),
            // ),
            fontFamily: 'Lato',
          ),
          home: ProductOverviewScreen(),
          routes: {
            DetailScreen.routeName: (context) => DetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },

          debugShowCheckedModeBanner: false


      ),
    );
  }
}

