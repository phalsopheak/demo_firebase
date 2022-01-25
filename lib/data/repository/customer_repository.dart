import 'package:dartz/dartz.dart';
import 'package:demo_firebase/data/datasource/firestore/customer_datasource.dart';
import 'package:demo_firebase/data/model/customer_model.dart';
import 'package:demo_firebase/domain/repository/customer_repository_interface.dart';
import 'package:demo_firebase/domain/util/app_error.dart';

class CustomerRepository extends ICustomerRepository {
  final ICustomerDataSource customerDataSource;

  CustomerRepository({
    required this.customerDataSource,
  });

  @override
  Future<Either<AppError, List<CustomerModel>>> getListOfCustomer() {
    return customerDataSource.getListOfCustomer();
  }

  @override
  Future<Either<AppError, String>> saveCustomer(CustomerModel model) {
    return customerDataSource.saveCustomer(model);
  }
}
