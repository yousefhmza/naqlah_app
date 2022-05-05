import 'package:flutter/cupertino.dart';

class ProductsHelper {
  ProductsHelper._privateConstructor();

  static final ProductsHelper instance = ProductsHelper._privateConstructor();

  Animation<Offset> slideAnimation(Animation<double> controller) =>
      Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeIn));

  Animation<double> opacityAnimation(Animation<double> controller) =>
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn),
      );

// int reservationPage = 1;
//
// String? searchedSpecialization;
// Map<String, dynamic>? searchedGovernorate;
// Map<String, dynamic>? searchedCity;
// List<int>? searchedPriceRange;
//
// void setQueries({
//   String? specialization,
//   dynamic gov,
//   dynamic city,
//   dynamic priceRange,
// }) {
//   searchedSpecialization = specialization ?? searchedSpecialization;
//   searchedGovernorate = gov ?? searchedGovernorate;
//   searchedCity = city ?? searchedCity;
//   searchedPriceRange = priceRange ?? searchedPriceRange;
// }
//
// void resetQueries() {
//   searchedSpecialization = null;
//   searchedGovernorate = null;
//   searchedCity = null;
//   searchedPriceRange = null;
//   emit(ReservationInitialState());
// }
}
