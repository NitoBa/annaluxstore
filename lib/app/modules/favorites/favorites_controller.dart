import 'package:annaluxstore/app/modules/buy/models/product_store_model.dart';
import 'package:annaluxstore/app/modules/home/home_controller.dart';
import 'package:annaluxstore/app/modules/home/models/product_model.dart';

import 'package:mobx/mobx.dart';

part 'favorites_controller.g.dart';

class FavoritesController = _FavoritesControllerBase with _$FavoritesController;

abstract class _FavoritesControllerBase with Store {
  final HomeController _homeController;
  @observable
  ObservableList<ProductModelStore> favoriteProducts;

  _FavoritesControllerBase(this._homeController);

  List<ProductModel> get favorites => _homeController.favoriteProducts;

  @action
  getFavoriteProducts() {
    var favorites = _homeController.favoriteProducts;

    var storeProductModel = ProductModelStore();

    favoriteProducts = favorites
        .map((product) => storeProductModel.transformModel(product))
        .toList()
        .asObservable();

    //print(favoriteProducts);
  }

  @action
  removeFavoriteProducts(ProductModelStore productModelStore) async {
    if (favoriteProducts != null) {
      favoriteProducts.removeWhere(
        (favoriteProduct) => favoriteProduct.id == productModelStore.id,
      );

      _homeController.removeFavoriteProducts(productModelStore.id);
    }
  }
}
