import 'package:food_delivary/data/repository/history_repo.dart';
import 'package:food_delivary/model/cart_model.dart';
import 'package:food_delivary/model/history_model.dart';
import 'package:food_delivary/utils/app_constants.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final HistoryRepo historyRepo;
  HistoryController({required this.historyRepo});
  List<CartModelHistory> _cartHistoryList = [];
  //List<CartModelHistory> get cartHistoryList => _cartHistoryList;
  Map<String, List<CartModelHistory>> _resultData = {};
  Map<String, List<CartModelHistory>> get resultData => _resultData;
  bool _isLoaded = false;
  bool get idLoaded => _isLoaded;

//-----------------------------------------------------------
  Future<void> getCartHistoryData() async {
    _cartHistoryList = [];
    _resultData = {};
    _isLoaded = false;
    _cartHistoryList =
        await historyRepo.getCartHistoryList(AppConstants.tableName);
    if (_cartHistoryList.isNotEmpty) {
      processOfData();
    } else if (_cartHistoryList.isEmpty) {
      _isLoaded = true;
      update();
    }
    _isLoaded = true;

    update();
  }

//-----------------------------------------------------------
  Future<int> insertdata(
      String tableName, List<CartModel> cartModelItems) async {
    var nowTime = DateTime.now().toString();
    int insertSucceded = 0;
    int response = 0;
    for (int i = 0; i < cartModelItems.length; i++) {
      response = 0;
      CartModelHistory cartModelHistory;
      cartModelHistory = CartModelHistory(
          id: cartModelItems[i].id!,
          name: cartModelItems[i].name,
          price: cartModelItems[i].price,
          img: cartModelItems[i].img,
          quantity: cartModelItems[i].quantity,
          isExit: cartModelItems[i].isExit! ? 1 : 0,
          time: nowTime);
      //print("nowTime inserted => $nowTime ; for $i item");
      response = await historyRepo.insert(tableName, cartModelHistory.toMap());
      // print("response : $response");
      if (response > 0) {
        insertSucceded = insertSucceded + 1;
      }
    }
    print("response  after for :$response");
    print("insertSucceded  = $insertSucceded ");
    var deleted = 0;
    List<String> args = [];
    if (insertSucceded != cartModelItems.length) {
      print("insertSucceded != cartModelItems.length");
    }
    update();
    return deleted == 1 ? -1 : insertSucceded;
  }

  List<CartModelHistory> valueItems = [];

  //-----------------------------------------------------------
  List<String> get getkeys {
    if (_resultData.isNotEmpty) {
      return _resultData.entries.map((e) => e.key).toList();
    } else {
      return [];
    }
  }

//-----------------------------------------------------------
  List<int> get countItemsOrdersList {
    if (_resultData.isNotEmpty) {
      return _resultData.entries.map((e) => e.value.length).toList();
    } else {
      return [];
    }
  }

//-----------------------------------------------------------
  List<List<CartModelHistory>> get itemsOrdersList {
    if (_resultData.isNotEmpty) {
      return _resultData.entries.map((e) => e.value).toList();
    } else {
      return [];
    }
  }

//-----------------------------------------------------------
  void processOfData() {
    for (int i = 0; i < _cartHistoryList.length; i++) {
      valueItems = [];
      var keys = getkeys;
      if (keys.isEmpty) {
        for (var element in _cartHistoryList) {
          if (element.time == _cartHistoryList[i].time) {
            valueItems.add(element);
          }
        }
        _resultData.putIfAbsent(_cartHistoryList[i].time!, () => valueItems);
      } else if (keys.isNotEmpty) {
        if (keys.contains(_cartHistoryList[i].time)) {
        } else {
          for (var element in _cartHistoryList) {
            if (element.time == _cartHistoryList[i].time) {
              valueItems.add(element);
            }
          }
          _resultData.putIfAbsent(_cartHistoryList[i].time!, () => valueItems);
        }
      }
    }
  }

  //-----------------------------------------------------------

  void clearHistoryList() {
    if (_resultData.isNotEmpty) {
      _cartHistoryList.clear();
      _resultData.clear();
      _isLoaded = true;
      update();
    } else {
      _isLoaded = true;
      update();
    }
  }
  //-----------------------------------------------------------
}
