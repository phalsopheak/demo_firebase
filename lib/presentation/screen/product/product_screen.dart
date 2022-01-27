import 'package:demo_firebase/core/enum/transaction_enum.dart';
import 'package:demo_firebase/presentation/controller/product_controller.dart';
import 'package:demo_firebase/presentation/screen/product/product_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController productController = Get.find();
  @override
  void initState() {
    productController.loadProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const ProductForm(transactionMode: TransactionMode.add),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: productController.listProduct
                .map(
                  (productModel) => GestureDetector(
                    onTap: () {
                      productController.selectProduct(productModel);
                      Get.to(
                        () => const ProductForm(
                            transactionMode: TransactionMode.edit),
                      );
                    },
                    child: Card(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(productModel.name),
                                productModel.listPicture != null
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: productModel.listPicture!
                                              .map(
                                                (x) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                productController
                                    .deleteProduct(productModel.id);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
