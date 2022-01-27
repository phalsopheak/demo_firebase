import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_firebase/core/constant/firestore_collection.dart';
import 'package:demo_firebase/core/enum/app_error_type_enum.dart';
import 'package:demo_firebase/data/model/product_model.dart';
import 'package:demo_firebase/domain/util/app_error.dart';

abstract class IProductDataSource {
  Future<Either<AppError, String>> saveProduct(ProductModel model);
  Future<Either<AppError, String>> updateProduct(ProductModel model);
  Future<Either<AppError, String>> deleteProduct(String recordId);
  Future<Either<AppError, List<ProductModel>>> getListOfProduct();
}

class ProductDataSource extends IProductDataSource {
  @override
  Future<Either<AppError, List<ProductModel>>> getListOfProduct() async {
    List<ProductModel> listProduct = [];
    try {
      await FirestoreCollection.product.get().then(
        (QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            listProduct.add(
              ProductModel.fromQueryDocumentSnapshot(doc),
            );
          }
        },
      );
      return Right(listProduct);
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
  Future<Either<AppError, String>> saveProduct(ProductModel model) async {
    try {
      await FirestoreCollection.product.doc(model.id).set(model.toMap());
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

  @override
  Future<Either<AppError, String>> updateProduct(ProductModel model) async {
    try {
      await FirestoreCollection.product.doc(model.id).set(model.toMap());
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

  @override
  Future<Either<AppError, String>> deleteProduct(String recordId) async {
    try {
      await FirestoreCollection.product.doc(recordId).delete();
      return Right(recordId);
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
