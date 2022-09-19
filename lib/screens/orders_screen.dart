import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_items.dart';

import '../providers/orders.dart' show Orders;

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

Future _ordersFuture;
Future _obtainOrdersFuture()
{
  return  Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
}
@override
  void initState() {

  _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: _ordersFuture,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData && !snapshot.hasError) {
                // print('there is the list ${ orderData.orders.length}');

                return Center(child: CircularProgressIndicator());
              } else {
                return Consumer<Orders>(
                builder: (context, orderData, child) =>
                    ListView.builder(
                        itemCount: orderData.orders.length,
                        itemBuilder: (context, index) =>
                            OrderItem(orderData.orders[index]))
                );
                  // itemBuilder: (context, index) => OrderItem(orderData.orders[index])) ,

              }
            }));
  }
}
