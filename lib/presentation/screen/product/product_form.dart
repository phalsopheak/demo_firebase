import 'dart:io';

import 'package:demo_firebase/core/constant/firebase_storage.dart';
import 'package:demo_firebase/core/enum/transaction_enum.dart';

import 'package:demo_firebase/data/model/picture_model.dart';
import 'package:demo_firebase/data/model/product_model.dart';

import 'package:demo_firebase/presentation/controller/product_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductForm extends StatefulWidget {
  final TransactionMode transactionMode;

  const ProductForm({
    Key? key,
    required this.transactionMode,
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final ProductController productController = Get.find();

  late TextEditingController tecName;
  late TextEditingController tecPrice;

  List<XFile>? listOfPictureFile;
  List<PictureModel>? listOfPictureModel;

  @override
  void initState() {
    tecName = TextEditingController();
    tecPrice = TextEditingController();
    if (widget.transactionMode == TransactionMode.edit) {
      tecName.text = productController.selectedProduct.name;
      tecPrice.text = productController.selectedProduct.price.toString();
      listOfPictureModel = productController.selectedProduct.listPicture;
    }
    super.initState();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecPrice.dispose();
    super.dispose();
  }

  getImage() async {
    var picker = ImagePicker();

    try {
      var imageFile = await picker.pickMultiImage();
      setState(() {
        listOfPictureFile = imageFile;
      });
    } catch (e) {
      Get.snackbar('Error', 'Can not use picture');
    }
  }

  removeImage() {
    setState(() {
      listOfPictureFile = null;
    });
  }

  saveProduct(ProductModel model) async {
    List<PictureModel> listBrowsePicture = [];
    if (listOfPictureFile != null) {
      var recordNumber = 1;

      for (var img in listOfPictureFile!) {
        firebase_storage.TaskSnapshot snapshot = await FirebaseStorageReference
            .customerProfile
            .child('${model.id} $recordNumber.jpg')
            .putFile(
              File(img.path),
              firebase_storage.SettableMetadata(contentType: 'image/jpg'),
            );
        if (snapshot.state == firebase_storage.TaskState.success) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          listBrowsePicture.add(
            PictureModel(
              id: '${model.id} $recordNumber',
              pictureUrl: downloadUrl,
            ),
          );
          // model = model.copyWith(listPicture: downloadUrl);
        } else if (snapshot.state == firebase_storage.TaskState.error) {
          Get.snackbar('Error', 'Upload profile picture problem');
          return;
        }
        recordNumber++;
      }
    }
    listOfPictureModel =
        listBrowsePicture.isNotEmpty ? listBrowsePicture : null;
    model = model.copyWith(listPicture: listOfPictureModel);
    productController.saveProduct(model);
  }

  updateProduct(ProductModel model) async {
    List<PictureModel> listBrowsePicture = [];
    if (listOfPictureFile != null) {
      var recordNumber = 1;
      for (var img in listOfPictureFile!) {
        firebase_storage.TaskSnapshot snapshot = await FirebaseStorageReference
            .customerProfile
            .child('${model.id} $recordNumber.jpg')
            .putFile(
              File(img.path),
              firebase_storage.SettableMetadata(contentType: 'image/jpg'),
            );
        if (snapshot.state == firebase_storage.TaskState.success) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          listBrowsePicture.add(
            PictureModel(
              id: '${model.id} $recordNumber',
              pictureUrl: downloadUrl,
            ),
          );
          // model = model.copyWith(listPicture: downloadUrl);
        } else if (snapshot.state == firebase_storage.TaskState.error) {
          Get.snackbar('Error', 'Upload profile picture problem');
          return;
        }
        recordNumber++;
      }
    }

    if (listOfPictureModel != null) {
      listOfPictureModel = listOfPictureModel! + listBrowsePicture;
    }

    listOfPictureModel ??=
        listBrowsePicture.isNotEmpty ? listBrowsePicture : null;

    model = model.copyWith(listPicture: listOfPictureModel);
    productController.updateProduct(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.transactionMode == TransactionMode.add
            ? const Text('Add Product')
            : const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.transactionMode == TransactionMode.add) {
                var id = const Uuid().v1();
                var model = ProductModel(
                  id: id,
                  name: tecName.text,
                  price: double.tryParse(tecPrice.text) ?? 0,
                );
                saveProduct(model);
              } else {
                var model = ProductModel(
                  id: productController.selectedProduct.id,
                  name: tecName.text,
                  price: double.tryParse(tecPrice.text) ?? 0,
                );
                updateProduct(model);
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: tecName,
            decoration: const InputDecoration(
              labelText: 'Product Name',
            ),
          ),
          TextField(
            controller: tecPrice,
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  getImage();
                },
                icon: const Icon(Icons.image),
              ),
              IconButton(
                onPressed: () {
                  removeImage();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          productController.selectedProduct.listPicture != null
              ? Row(
                  children: productController.selectedProduct.listPicture!
                      .map(
                        (x) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              x.pictureUrl,
                              fit: BoxFit.fill,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : const SizedBox.shrink(),
          listOfPictureFile != null
              ? Row(
                  children: listOfPictureFile!
                      .map(
                        (x) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                              File(x.path),
                              fit: BoxFit.fill,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
