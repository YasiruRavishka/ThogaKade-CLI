import '../model/Vegetable.dart';
import '../repository/AppRepository.dart';

class Validator {
  bool is_valid_cart_item(int itemId, int itemQty) {
    try {
      final Vegetable veg = AppRepository().searchVegetableById(itemId)!;
      if (veg.isExpired()) {
        throw FormatException("Expired item!");
      }
      if (!isAvailableQty(veg, itemQty)) {
        throw FormatException("Item qty is over the limit!");
      }
      return true;
    } on FormatException catch (e) {
      print("Invalid, $e");
    } catch (e) {
      print("Invalid vegId");
    }
    return false;
  }

  bool isAvailableQty(Vegetable veg,int qty) {
    return 0 < qty && qty <= veg.availableQuantity;
  }
}