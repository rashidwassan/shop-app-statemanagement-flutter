import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const String id = '/EditProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  // this manages which textFormField is to be in focus...
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);

    _form.currentState!.save();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'), actions: [
        IconButton(icon: const Icon(Icons.save), onPressed: _saveForm)
      ]),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value!,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if (value == '') return 'Please provide a value';
              },
              onFieldSubmitted: (_) {
                // assigning focus node to next field
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              onSaved: (value) {
                _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value.toString()),
                    imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if (value!.isEmpty) return 'Please enter a price.';
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number.';
                }
                if (double.parse(value) <= 0) {
                  return 'The number must be greater than 0.';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                // assigning focus node to next field
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter description';
                }
                if (value.length < 10) {
                  return 'The description must be more than 10 characters';
                }
              },
              onFieldSubmitted: (_) {
                // assigning focus node to next field
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? const Text('Enter a Url').centered()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Image Url',
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value!);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter image Url';
                      }
                      if (!value.startsWith('http') ||
                          !value.startsWith('https')) {
                        return 'Please enter a valid Url';
                      }
                    },
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ).p(24),
    );
  }
}
