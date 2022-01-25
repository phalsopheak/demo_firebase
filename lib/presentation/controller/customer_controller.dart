import 'package:demo_firebase/data/model/customer_model.dart';
import 'package:demo_firebase/domain/usecase/customer_usecase.dart';
import 'package:demo_firebase/domain/util/no_param.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  final GetListOfCustomerUseCase getListOfCustomerUseCase;
  final SaveCustomerUseCase saveCustomerUseCase;

  var listCustomer = RxList<CustomerModel>();
  var selectedCustomer = CustomerModel(id: '', name: '');

  CustomerController({
    required this.getListOfCustomerUseCase,
    required this.saveCustomerUseCase,
  });

  selectCustomer(CustomerModel model) {
    selectedCustomer = model;
  }

  loadCustomer() async {
    var response = await getListOfCustomerUseCase.call(NoParam());
    response.fold(
      (l) {
        Get.snackbar('Error', 'Load Data');
      },
      (r) {
        listCustomer.assignAll(r);
      },
    );
  }

  saveCustomer(CustomerModel model) async {
    var response = await saveCustomerUseCase.call(model);
    response.fold(
      (l) {
        Get.snackbar('Error', 'Can not save data');
      },
      (r) {
        listCustomer.add(model);
        Get.back();
      },
    );
  }
}
