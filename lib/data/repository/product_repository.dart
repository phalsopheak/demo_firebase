import 'package:dartz/dartz.dart';
import 'package:demo_firebase/data/datasource/firestore/product_datasource.dart';

import 'package:demo_firebase/data/model/product_model.dart';

import 'package:demo_firebase/domain/repository/product_repository_interface.dart';
import 'package:demo_firebase/domain/util/app_error.dart';

class ProductRepository extends IProductRepository {
  final IProductDataSource productDataSource;

  ProductRepository({
    required this.productDataSource,
  });

  @override
  Future<Either<AppError, List<ProductModel>>> getListOfProduct() {
    return productDataSource.getListOfProduct();
  }

  @override
  Future<Either<AppError, String>> saveProduct(ProductModel model) {
    return productDataSource.saveProduct(model);
  }

  @override
  Future<Either<AppError, String>> updateProduct(ProductModel model) {
    return productDataSource.updateProduct(model);
  }

  @override
  Future<Either<AppError, String>> deleteProduct(String recordId) {
    return productDataSource.deleteProduct(recordId);
  }
}
