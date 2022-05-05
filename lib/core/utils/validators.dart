import '../resources/strings_manager.dart';
import '../extensions/non_null_extensions.dart';
import 'constants.dart';

class Validators {
  static String? phoneNumberValidator(String? value) {
    return value.orEmpty.length < Constants.egyptianPhoneNumberLength ||
            (!value.orEmpty.startsWith("01") && !value.orEmpty.startsWith("1"))
        ? AppStrings.phoneValidator
        : null;
  }

  static String? userNameValidator(String? value) =>
      value.orEmpty.length < 4 ? AppStrings.nameValidator : null;

  static String? storeNameValidator(String? value) =>
      value.orEmpty.length < 2 ? AppStrings.storeNameValidator : null;

  static String? addressValidator(String? value) =>
      value.orEmpty.isEmpty ? AppStrings.addressValidator : null;

  static String? passwordValidator(String? value) =>
      value.orEmpty.length < 8 ? AppStrings.passwordValidator : null;

  static String? minAmountValidator(String? value) =>
      value.orEmpty.isEmpty ? AppStrings.prodMinAmountValidator : null;

  static String? maxAmountValidator(String? value) =>
      value.orEmpty.isEmpty ? AppStrings.prodMaxAmountValidator : null;

  static String? priceValidator(String? value) =>
      value.orEmpty.isEmpty ? AppStrings.prodMaxAmountValidator : null;

  static String? priceUnitValidator(String? value) =>
      value.orEmpty.isEmpty ? AppStrings.priceUnitValidator : null;

  static String? prodNameValidator(String? value) =>
      value.orEmpty.isEmpty ? AppStrings.prodNameValidator : null;
}
