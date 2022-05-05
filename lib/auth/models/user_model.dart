import '../../core/utils/constants.dart';
import '../../core/utils/globals.dart';
import 'city.dart';
import 'governorate.dart';

enum UserType {
  customer,
  seller,
  unKnown, // in case of unable to retrieve data
}

class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String password;
  final UserType userType;
  final String storeName;
  final String storeAddress;
  final City storeCity;
  final Governorate storeGovernorate;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.userType,
    required this.storeName,
    required this.storeAddress,
    required this.storeCity,
    required this.storeGovernorate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? Constants.empty,
        name: json["name"] ?? Constants.empty,
        phoneNumber: json["phone_number"] ?? Constants.empty,
        password: json["password"] ?? Constants.empty,
        userType: _toUserType(json["user_type"]),
        storeName: json["store_name"] ?? Constants.empty,
        storeAddress: json["store_address"] ?? Constants.empty,
        storeCity: _toCity(json["store_city"]),
        storeGovernorate: _toGovernorate(json["store_governorate"]),
      );

  static UserType _toUserType(String? userTypeString) {
    if (userTypeString != null) {
      return userTypeString == "customer" ? UserType.customer : UserType.seller;
    } else {
      return UserType.unKnown;
    }
  }

  static City _toCity(String? cityId) {
    if (cityId != null) {
      for (var city in cities) {
        if (city.id == cityId) {
          return city;
        }
      }
    }
    return City(id: "", governorateId: "", name: "", nameAr: "");
  }

  static Governorate _toGovernorate(String? govId) {
    if (govId != null) {
      for (var governorate in governorates) {
        if (governorate.id == govId) {
          return governorate;
        }
      }
    }
    return Governorate(id: "", name: "", nameAr: "");
  }
}
