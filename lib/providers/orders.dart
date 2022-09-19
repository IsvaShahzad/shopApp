import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/order_items.dart';
import 'cart.dart';
import 'package:http/http.dart'
    as http; //to access all the features for the package
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {

    final url = Uri.parse(
        'https://shopapp-3ab85-default-rtdb.firebaseio.com' + '/orders.json');

    final response = await http.get(url);
    final List<OrderItem> loadedOrder = [];
    final extractedData = json.encode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrder.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products:
              (orderData['products'] as List<dynamic>).map((item) => CartItems(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                  ))

      ));
    });

    _orders = loadedOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItems> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shopapp-3ab85-default-rtdb.firebaseio.com' + '/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(), //cp is cart product
      }),
    );

    _orders.insert(
        0,
        OrderItem(
            id: json.encode(response.body),
            amount: total,
            dateTime: timestamp,
            products: cartProducts));
    notifyListeners();
  }
}
