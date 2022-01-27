import 'package:dartz/dartz.dart';
import 'package:demo_firebase/data/model/product_model.dart';
import 'package:demo_firebase/domain/repository/product_repository_interface.dart';
import 'package:demo_firebase/domain/usecase/usecase.dart';
import 'package:demo_firebase/domain/util/app_error.dart';
import 'package:demo_firebase/domain/util/no_param.dart';

class GetListOfProductUseCase
    extends UseCaseFuture<List<ProductModel>, NoParam> {
  final IProductRepository productRepository;

  GetListOfProductUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<AppError, List<ProductModel>>> call(NoParam parameter) async {
    return await productRepository.getListOfProduct();
  }
}

class SaveProductUseCase extends UseCaseFuture<String, ProductModel> {
  final IProductRepository productRepository;

  SaveProductUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<AppError, String>> call(ProductModel parameter) async {
    return await productRepository.saveProduct(parameter);
  }
}

class UpdateProductUseCase extends UseCaseFuture<String, ProductModel> {
  final IProductRepository productRepository;

  UpdateProductUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<AppError, String>> call(ProductModel parameter) async {
    return await productRepository.updateProduct(parameter);
  }
}

class DeleteProductUseCase extends UseCaseFuture<String, String> {
  final IProductRepository productRepository;

  DeleteProductUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<AppError, String>> call(String parameter) async {
    return await productRepository.deleteProduct(parameter);
  }
}
