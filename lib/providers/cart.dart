import 'package:flutter/foundation.dart';

class CartItems {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItems(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = { };

  Map<String, CartItems> get items //to add into new map and get a copy
  {
    return {..._items};
  }

  int get itemCount
  {
    return _items.length;
  }



  double get totalAmount {
    var total= 0.0;
    _items.forEach((key, cartItem)  {
      total+= cartItem.price*cartItem.quantity;
    });
    return total;
  }

  void addItems(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
//.. only change quantity cause the id is present if it's the same id already found in the cart

    _items.update(productId, (existingCartItems) => CartItems(
        id: existingCartItems.id,
        title: existingCartItems.title,
        price: existingCartItems.price,
        quantity: existingCartItems.quantity+1,
    )
    );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItems(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
  void removeitem(String productId)
  {
    _items.remove(productId);
    notifyListeners();
  }

  void RemoveSingleItem(String productId)
  {
    if( !_items.containsKey(productId))
      {
        return;
      }
    if(_items[productId].quantity > 1)
    {
      _items.update(
          productId,
              (existingCartItem) => CartItems(
                  id: existingCartItem.id,
                  title: existingCartItem.title,
                  quantity: existingCartItem.quantity -1,
                  price: existingCartItem.price,
              )
      );
      
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }
void clear()
{
  _items= {};
  notifyListeners();

}
}
