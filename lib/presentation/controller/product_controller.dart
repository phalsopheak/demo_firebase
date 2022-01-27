import 'package:demo_firebase/data/model/product_model.dart';
import 'package:demo_firebase/domain/usecase/product_usecase.dart';
import 'package:demo_firebase/domain/util/no_param.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final GetListOfProductUseCase getListOfProductUseCase;
  final SaveProductUseCase saveProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  var listProduct = RxList<ProductModel>();
  var selectedProduct = ProductModel(id: '', name: '', price: 0);

  ProductController({
    required this.getListOfProductUseCase,
    required this.saveProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  });

  selectProduct(ProductModel model) {
    selectedProduct = model;
  }

  loadProduct() async {
    listProduct.clear();
    var response = await getListOfProductUseCase.call(NoParam());
    response.fold(
      (l) {
        Get.snackbar('Error', 'Load Data');
      },
      (r) {
        listProduct.assignAll(r);
      },
    );
  }

  saveProduct(ProductModel model) async {
    var response = await saveProductUseCase.call(model);
    response.fold(
      (l) {
        Get.snackbar('Error', 'Can not save data');
      },
      (r) {
        listProduct.add(model);
        Get.back();
      },
    );
  }

  updateProduct(ProductModel model) async {
    var response = await updateProductUseCase.call(model);
    response.fold(
      (l) {
        Get.snackbar('Error', 'Can not update data');
      },
      (r) {
        var id = listProduct.indexWhere(
          (x) => x.id == model.id,
        );
        listProduct[id] = model;
        Get.back();
      },
    );
  }

  deleteProduct(String recordId) async {
    var response = await deleteProductUseCase.call(recordId);
    response.fold(
      (l) {
        Get.snackbar('Error', 'Can not delete data');
      },
      (r) {
        listProduct.removeWhere((x) => x.id == recordId);
      },
    );
  }
}
