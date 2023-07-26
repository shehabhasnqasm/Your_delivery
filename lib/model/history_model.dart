import '../utils/app_constants.dart';

class CartModelHistory {
  late int id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  int? isExit;
  String? time;

  CartModelHistory({
    required this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExit,
    this.time,
  });

  CartModelHistory.fromMap(Map<String, dynamic> json) {
    id = json[AppConstants.colId];
    name = json[AppConstants.colName];
    price = json[AppConstants.colPrice];
    img = json[AppConstants.colImg];
    quantity = json[AppConstants.colQuantity];
    isExit = json[AppConstants.colIsExit];
    time = json[AppConstants.colTime];
  }
  Map<String, dynamic> toMap() {
    return {
      AppConstants.colId: id,
      AppConstants.colName: name,
      AppConstants.colPrice: price,
      AppConstants.colImg: img,
      AppConstants.colQuantity: quantity,
      AppConstants.colIsExit: isExit,
      AppConstants.colTime: time,
    };
  }
}
