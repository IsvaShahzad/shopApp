import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemOnScreen extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productid;

  CartItemOnScreen(this.id,this.productid, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(' Are you sure?'),
              content: Text('Do you want to remove the item from the cart?'),
              actions: <Widget>[
                TextButton(

                    child: Text('No'),
                  onPressed: (){
                      Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                    child: Text('Yes'),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                )

              ],
            ),
        );
      },
      onDismissed: (direction)
      {
        
        Provider.of<Cart>(context, listen: false).removeitem(productid);

      }  ,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
