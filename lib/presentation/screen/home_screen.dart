import 'package:demo_firebase/presentation/screen/customer/customer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Firebase'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => CustomerScreen());
              },
              child: const Text('Customer Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => CustomerScreen());
              },
              child: const Text('Product Demo'),
            ),
          ],
        ),
      ),
    );
  }
}
