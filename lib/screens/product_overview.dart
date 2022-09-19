import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import './cart_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';


enum FilterOptions //ways of assigning integers to labels
{
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

  var _showOnlyFavourites = false;
  var _isInit = true;
  var _isLoading =false;

//   @override
//   void initState(){
//
//   // Provider.of<Products>(context).fetchandSetProducts();  THIS WONT WORK, CONTEXT DOESNT WORK INSIDE INIT STATE
//   super.initState();
// }

@override
void didChangeDependencies()
 {
  if(_isInit){
    setState((){
      _isLoading=true;

    });
    Provider.of<Products>(context).fetchandSetProducts().then((_)
    // context.read<Products>().fetchandSetProducts();
    {
      setState((){
        _isLoading=false;

      });
    }
    );
  }
  _isInit=false;
  super.didChangeDependencies();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {

                if(selectedValue == FilterOptions.Favourites)
                {
                  _showOnlyFavourites=true;

                }else
                {
                  _showOnlyFavourites=false;

                }

              });

            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              //(_) use when we do not want to give any context
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),

              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
         Consumer<Cart>(builder: (_, cart, ch) => Badge(
           child: ch,
           value: cart.itemCount.toString(),
         ),
           child: IconButton(
               onPressed: (){
                 Navigator.of(context).pushNamed(CartScreen.routeName);
               },
               icon: Icon(Icons.shopping_cart))
           ,)
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(
        child:  CircularProgressIndicator(),
      ): ProductsGrid(_showOnlyFavourites),
    );
  }
}
