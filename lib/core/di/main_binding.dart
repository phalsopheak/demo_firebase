import 'package:demo_firebase/data/datasource/firestore/customer_datasource.dart';
import 'package:demo_firebase/data/repository/customer_repository.dart';
import 'package:demo_firebase/domain/repository/customer_repository_interface.dart';
import 'package:demo_firebase/domain/usecase/customer_usecase.dart';
import 'package:demo_firebase/presentation/controller/customer_controller.dart';
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
  }
}
