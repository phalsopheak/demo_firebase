import 'package:dartz/dartz.dart';
import 'package:demo_firebase/data/model/product_model.dart';
import 'package:demo_firebase/domain/util/app_error.dart';

abstract class IProductRepository {
  Future<Either<AppError, String>> saveProduct(ProductModel model);
  Future<Either<AppError, String>> updateProduct(ProductModel model);
  Future<Either<AppError, String>> deleteProduct(String recordId);
  Future<Either<AppError, List<ProductModel>>> getListOfProduct();
}
