import 'package:e_client/models/product.dart';
import 'package:e_client/utility/snack_bar_helper.dart';
import 'package:e_client/utility/utility_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';
import '../../../core/data/data_provider.dart';

class ProductDetailProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._dataProvider);

  //TODO: should complete addToCart

  addToCart(Product product) {
    if (product.proVariantId!.isNotEmpty && selectedVariant == null) {
      SnackBarHelper.showErrorSnackBar('Please Select a Variant');
      return;
    }
    double? price = product.offerPrice != product.price
        ? product.offerPrice
        : product.price;
    flutterCart.addToCart(
      cartModel: CartModel(
          productId: product.sId!,
          productName: product.name!,
          productImages: [product.images.safeElementAt(0)!.url!],
          variants: [ProductVariant(price: price ?? 0, color: selectedVariant)],
          productDetails: product.description!),
    );
    selectedVariant = null;
    SnackBarHelper.showSuccessSnackBar('Item Added');
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }
}
