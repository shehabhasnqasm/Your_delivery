class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  // static const String BASE_URL =
  //     "http://10.0.2.2:8000"; or  "http://127.0.0.1:8000" ; or "http://localhost:8000" for local server
  // static const String BASE_URL = "http://mvs.bslmeiyu.com"; from internet  (remote server)
  static const String baseUrl = "http://localhost:8000";
  //static const String BASE_URL = "https://mvs.bslmeiyu.com"; // is the truest baseUrl (use https:// for security)

  static const String popularProductUrl =
      "/api/v1/products/popular"; //http://localhost:8000/api/v1/products/popular
  static const String recomendedProductUrl = "/api/v1/products/recommended";
  // static const String DRINC_URI = "/api/v1/products/drincks";
  static const String uploadUrl = "/uploads/";

  //user and auth end point
  static const String registrationUri = "/api/v1/auth/register";
  static const String loginUri = "/api/v1/auth/login";
  static const String userInfoUri = "/api/v1/customer/info";

  //new
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/cusotmer/address/add";
  static const String ADD_LIST_URI = "/api/v1/cusotmer/address/list";

  static const String GEOCODE_URI = "/api/v1/config/geocode-api";

  static const String token = ""; // user token
  static const String phone = ""; // user phone
  static const String password = ""; // user password
  static const String cartList = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

  // database sqflite constants
  static const String dbName = "historydb.db";
  static const String tableName = 'cartList';
  static const String colId = 'id';
  static const String colName = 'name';
  static const String colPrice = 'price';
  static const String colImg = 'img';
  static const String colQuantity = 'quantity';
  static const String colIsExit = 'isExit';
  static const String colTime = 'time';
}
