import '../repository/InventoryDao.dart';

class Validator {
  bool is_valid_healthy_vegetable(int id) {
    for (final veg in InventoryDao().getAll()) {
      if (veg.id == id && !veg.isExpired()) {
        return true;
      }
    }
    return false;
  }
}