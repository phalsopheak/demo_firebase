import 'package:demo_firebase/data/datasource/firestore/customer_datasource.dart';
import 'package:demo_firebase/data/datasource/firestore/product_datasource.dart';
import 'package:demo_firebase/data/repository/customer_repository.dart';
import 'package:demo_firebase/data/repository/product_repository.dart';
import 'package:demo_firebase/domain/repository/customer_repository_interface.dart';
import 'package:demo_firebase/domain/repository/product_repository_interface.dart';
import 'package:demo_firebase/domain/usecase/customer_usecase.dart';
import 'package:demo_firebase/domain/usecase/product_usecase.dart';
import 'package:demo_firebase/presentation/controller/customer_controller.dart';
import 'package:demo_firebase/presentation/controller/product_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    //customer di
    Get.put<ICustomerDataSource>(
      CustomerDataSource(),
      permanent: true,
    );
    Get.put<ICustomerRepository>(
      CustomerRepository(
        customerDataSource: Get.find(),
      ),
      permanent: true,
    );
    Get.put<GetListOfCustomerUseCase>(
      GetListOfCustomerUseCase(
        customerRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put<SaveCustomerUseCase>(
      SaveCustomerUseCase(
        customerRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put<UpdateCustomerUseCase>(
      UpdateCustomerUseCase(
        customerRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put<DeleteCustomerUseCase>(
      DeleteCustomerUseCase(
        customerRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      CustomerController(
        getListOfCustomerUseCase: Get.find(),
        saveCustomerUseCase: Get.find(),
        updateCustomerUseCase: Get.find(),
        deleteCustomerUseCase: Get.find(),
      ),
      permanent: true,
    );

    //product di
    Get.put<IProductDataSource>(
      ProductDataSource(),
      permanent: true,
    );
    Get.put<IProductRepository>(
      ProductRepository(
        productDataSource: Get.find(),
      ),
      permanent: true,
    );
    Get.put<GetListOfProductUseCase>(
      GetListOfProductUseCase(
        productRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put<SaveProductUseCase>(
      SaveProductUseCase(
        productRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put<UpdateProductUseCase>(
      UpdateProductUseCase(
        productRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put<DeleteProductUseCase>(
      DeleteProductUseCase(
        productRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      ProductController(
        getListOfProductUseCase: Get.find(),
        saveProductUseCase: Get.find(),
        updateProductUseCase: Get.find(),
        deleteProductUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
