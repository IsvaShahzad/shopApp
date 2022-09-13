import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionfocusnode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  static final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(
            id: null,
          title: '',
          price: 0,
          description: '',
          imageUrl: '',
      );

  var _initValues = {
    'title': ' ',
    'description': '',
    'price': '',
    'imageUrl': '',

  };
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateimageUrl);
    super.initState();
  }
  //
  @override
  void didChangeDependencies()
  {
    if(_isInit) {
      final productId = ModalRoute
          .of(context)
          .settings
          .arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findbyId(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
         // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl' : '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateimageUrl);
    _priceFocusNode.dispose();
    _descriptionfocusnode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateimageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {

      if  ((!_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) || (!_imageUrlController.text.endsWith('.png') &&
          !_imageUrlController.text.endsWith('.jpg') &&
          !_imageUrlController.text.endsWith('.jpeg ')))
        {
          return;
        }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid)
      {
        return;
      }
    _form.currentState.save();

    //if product which is already added is added again, then dont add duplicate, otherwise add new product
    if(_editedProduct.id!= null){
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);

    }else
      {
        Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
      }
    Navigator.of(context).pop();

  }

  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) => FocusManager
          .instance.primaryFocus
          ?.unfocus(), //to dismiss keyboard on tap outside the field
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: <Widget>[
            IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                 initialValue : _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',

                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },

                  validator: (value) {
                    if(value.isEmpty){
                      return 'Please  provide a value';
                    }
                    return null;
                  },
                  onSaved: (value)
                  {
                    _editedProduct = Product(
                        title: value,
                        price: _editedProduct.price,
                        description: _editedProduct.description,
                        imageUrl: _editedProduct.imageUrl,
                        id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite ,
                    );
                  },
                ),
                TextFormField(
                 initialValue : _initValues['price'],

                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionfocusnode);
                  },
                  validator: (value)
                    {
                      if(value.isEmpty)
                        {
                          return 'Please enter a price';
                        }
                      if(double.tryParse(value) == null)
                        {
                          return 'Please enter a valid number';
                        }
                      if(double.parse(value) <= 0)
                        {

                          return 'Please enter a number greater than 0';

                        }
                      return null;

                    },

                  onSaved: (value)
                  {
                    _editedProduct = Product(
                      title: _editedProduct.title,
                      price: double.parse(value),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite ,
                    );
                  },

                ),
                TextFormField(
                  initialValue : _initValues['description'],

                  decoration: InputDecoration(
                    labelText: 'description',
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionfocusnode,
                  validator: (value)
                    {

                      if(value.isEmpty)
                        {
                          return 'Please enter a description';
                        }
                      if(value.length< 10)
                        {
                          return 'Value should be 10 characters long!';
                        }
                      return null;

                    },

                  onSaved: (value)
                  {
                    _editedProduct = Product(
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite ,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter a URL')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                        child: TextFormField(
                         // initialValue : _initValues['imageUrl'],

                          decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },

                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter image URL!';
                            }
                            if (value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter an image URl';
                            }

                            // if (!value.endsWith('.png') &&
                            //     !value.endsWith('jpg') &&
                            //     !value.endsWith('jpeg ')) {
                            //   return 'Please enter a valid image URL';
                            // }
                            return null;
                          },


                          onSaved: (value)
                          {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              imageUrl: value,
                              id: _editedProduct.id,
                              isFavourite: _editedProduct.isFavourite ,

                            );
                          },
                      onEditingComplete: () {
                        setState(() {});
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
