import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_firebase/core/constant/firestore_collection.dart';
import 'package:demo_firebase/core/enum/app_error_type_enum.dart';
import 'package:demo_firebase/data/model/customer_model.dart';
import 'package:demo_firebase/domain/util/app_error.dart';

abstract class ICustomerDataSource {
  Future<Either<AppError, String>> saveCustomer(CustomerModel model);
  Future<Either<AppError, List<CustomerModel>>> getListOfCustomer();
}

class CustomerDataSource extends ICustomerDataSource {
  @override
  Future<Either<AppError, List<CustomerModel>>> getListOfCustomer() async {
    List<CustomerModel> listCustomer = [];
    try {
      await FirestoreCollection.customer.get().then(
        (QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            listCustomer.add(
              CustomerModel.fromQueryDocumentSnapshot(doc),
            );
          }
        },
      );
      return Right(listCustomer);
    } catch (e) {
      return Left(
        AppError(
          appErrorType: AppErrorType.connection,
          description: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<AppError, String>> saveCustomer(CustomerModel model) async {
    try {
      await FirestoreCollection.customer.doc(model.id).set(model.toMap());
      return Right(model.id);
    } catch (e) {
      return Left(
        AppError(
          appErrorType: AppErrorType.connection,
          description: e.toString(),
        ),
      );
    }
  }
}
