import 'package:flutter/foundation.dart';

class Product with ChangeNotifier   {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;



  Product({
    @required this.id,  //using curly braces to add arguments as named instead of positional
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite= false,
  });

  void toggleFavouriteStatus()
  {
    isFavourite =! isFavourite;
    notifyListeners();
  }
}