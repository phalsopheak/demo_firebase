import 'package:dartz/dartz.dart';
import 'package:demo_firebase/data/model/customer_model.dart';
import 'package:demo_firebase/domain/repository/customer_repository_interface.dart';
import 'package:demo_firebase/domain/usecase/usecase.dart';
import 'package:demo_firebase/domain/util/app_error.dart';
import 'package:demo_firebase/domain/util/no_param.dart';

class GetListOfCustomerUseCase
    extends UseCaseFuture<List<CustomerModel>, NoParam> {
  final ICustomerRepository customerRepository;

  GetListOfCustomerUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<AppError, List<CustomerModel>>> call(NoParam parameter) async {
    return await customerRepository.getListOfCustomer();
  }
}

class SaveCustomerUseCase extends UseCaseFuture<String, CustomerModel> {
  final ICustomerRepository customerRepository;

  SaveCustomerUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<AppError, String>> call(CustomerModel parameter) async {
    return await customerRepository.saveCustomer(parameter);
  }
}

class UpdateCustomerUseCase extends UseCaseFuture<String, CustomerModel> {
  final ICustomerRepository customerRepository;

  UpdateCustomerUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<AppError, String>> call(CustomerModel parameter) async {
    return await customerRepository.updateCustomer(parameter);
  }
}

class DeleteCustomerUseCase extends UseCaseFuture<String, String> {
  final ICustomerRepository customerRepository;

  DeleteCustomerUseCase({
    required this.customerRepository,
  });

  @override
  Future<Either<AppError, String>> call(String parameter) async {
    return await customerRepository.deleteCustomer(parameter);
  }
}
