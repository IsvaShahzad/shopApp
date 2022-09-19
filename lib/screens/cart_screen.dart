import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: (ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) => CartItemOnScreen(
                      cart.items.values.toList()[index].id,
                      cart.items.keys.toList()[index],
                      cart.items.values.toList()[index].price,
                      cart.items.values.toList()[index].quantity,
                      cart.items.values.toList()[index].title))))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(

      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async{

        setState(() {
          _isLoading=true;
        });
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );

              setState(() {
                _isLoading=false;
              });

              widget.cart.clear();
            },
      style: TextButton.styleFrom(
        primary: Color(0xFFFF3988),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_complete_guide/screens/orders_screen.dart';
// import 'package:provider/provider.dart';
// import '../providers/cart.dart';
// import '../widgets/cart_item.dart';
// import '../providers/orders.dart';
//
// class CartScreen extends StatelessWidget {
//   static const routeName = '/cart';
//
//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<Cart>(context);
//     return Scaffold(
//       appBar: AppBar(title: Text('Your Cart')),
//       body: Column(
//         children: <Widget>[
//           Card(
//               margin: EdgeInsets.all(15),
//               child: Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(
//                           'Total',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Spacer(),
//                         Chip(
//                           label: Text(
//                             '\$${cart.totalAmount.toStringAsFixed(2)}',
//                             style: TextStyle(
//                                 color: Theme.of(context)
//                                     .primaryTextTheme
//                                     .titleSmall
//                                     .color),
//                           ),
//                           backgroundColor: Theme.of(context).primaryColor,
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Provider.of<Orders>(context, listen: false)
//                                   .addOrder(
//                                 cart.items.values.toList(),
//                                 cart.totalAmount,
//                               );
//                                   cart.clear();
//
//                             },
//                             child: Text('Order Now!'))
//                       ]))),
//           SizedBox(
//             height: 10,
//           ),
//           Expanded(
//               child: (ListView.builder(
//                   itemCount: cart.itemCount,
//                   itemBuilder: (context, index) => CartItemOnScreen(
//                       cart.items.values.toList()[index].id,
//                       cart.items.keys.toList()[index],
//                       cart.items.values.toList()[index].price,
//                       cart.items.values.toList()[index].quantity,
//                       cart.items.values.toList()[index].title))))
//         ],
//       ),
//     );
//   }
// }
//
// //                   OrderButton(cart: cart)
// //                 ],
// //               ),
// //             ),
// //           ),
// //           SizedBox(
// //             height: 10,
// //           ),
// //           Expanded(
// //               child: (ListView.builder(
// //                   itemCount: cart.itemCount,
// //                   itemBuilder: (context, index) => CartItemOnScreen(
// //                       cart.items.values.toList()[index].id,
// //                       cart.items.keys.toList()[index],
// //                       cart.items.values.toList()[index].price,
// //                       cart.items.values.toList()[index].quantity,
// //                       cart.items.values.toList()[index].title))))
// //         ],
// //       ),
// //
// //
// //     final Cart cart;
// //
// //
// //         var _isLoading = false;
// //
// //     );
// //   }
// // }
// //
// //
// //
// //   @override
// //
// //   Widget build(BuildContext context) {
// //     return TextButton(
// //       child: Text('Order Now'),
// //       onPressed:
// //
// //       widget.cart.totalAmount<=0
// //
// //             ? null
// //             : () {
// //     setState(() {
// //     _isLoading = true;
// //     });
// //
// //     Provider.of<Orders>(context, listen: false).addOrder(
// //     widget.cart.items.values.toList(),
// //     widget.cart.totalAmount,
// //     );
// //
// //     setState(() {
// //
// //     _isLoading=false;
// //     });
// //
// //     widget.cart.clear();
// //     },
// //           // Navigator.pushReplacement<void, void>(
// //           //   context,
// //           //   MaterialPageRoute<void>(
// //           //     builder: (BuildContext context) =>  OrderScreen(),
// //           //   ),
// //           // );
// //
// //
// //       style: TextButton.styleFrom(
// //         primary: Color(0xFFFF3988),
// //       ),
// //     );
// //   }
