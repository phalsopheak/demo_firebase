import 'package:dartz/dartz.dart';
import 'package:demo_firebase/data/model/customer_model.dart';
import 'package:demo_firebase/domain/util/app_error.dart';

abstract class ICustomerRepository {
  Future<Either<AppError, String>> saveCustomer(CustomerModel model);
  Future<Either<AppError, List<CustomerModel>>> getListOfCustomer();
}
