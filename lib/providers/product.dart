import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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

  void _setfavValue(bool newValue)
  {
    isFavourite = newValue;
    notifyListeners();
  }


  Future<void> toggleFavouriteStatus()
    async{
    final oldStatus = isFavourite;
    isFavourite =! isFavourite;
    notifyListeners();
    final url = Uri.parse(
        'https://shopapp-3ab85-default-rtdb.firebaseio.com' +
            '/products/$id.json');
   try{
   final response = await http.patch(url, body:json.encode ({

      'isFavourite' : isFavourite,

    }),
    );
    if (response.statusCode >= 400)
      {
        _setfavValue(oldStatus);

      }

  }catch(error)
      {
        _setfavValue(oldStatus);
      }
}}