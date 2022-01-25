import 'package:demo_firebase/core/enum/transaction_enum.dart';
import 'package:demo_firebase/presentation/controller/customer_controller.dart';
import 'package:demo_firebase/presentation/screen/customer/customer_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final CustomerController customerController = Get.find();
  @override
  void initState() {
    customerController.loadCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const CustomerForm(transactionMode: TransactionMode.add),
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
            children: customerController.listCustomer
                .map(
                  (customerModel) => GestureDetector(
                    onTap: () {
                      customerController.selectCustomer(customerModel);
                      Get.to(
                        () => const CustomerForm(
                            transactionMode: TransactionMode.edit),
                      );
                    },
                    child: Card(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Row(
                          children: [
                            customerModel.profilePicture == null
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      customerModel.profilePicture!,
                                      fit: BoxFit.fill,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                            Text(customerModel.name),
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
