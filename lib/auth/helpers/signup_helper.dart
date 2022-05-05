import 'package:flutter/material.dart';

import '../../core/utils/globals.dart';
import '../components/signup_steps/otp_step.dart';
import '../components/signup_steps/phone_step.dart';
import '../components/signup_steps/register_step.dart';
import '../components/signup_steps/user_type_step.dart';
import '../models/city.dart';
import '../models/governorate.dart';
import '../models/user_model.dart';

// this class stores some data and variables and execute functions related to signup process
class SignupHelper {
  SignupHelper._privateConstructor();

  static final SignupHelper instance = SignupHelper._privateConstructor();

  late PageController pageController;
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  String? _otp;
  UserType? _selectedUserType;
  late TextEditingController phoneController;
  late TextEditingController usernameController;
  late TextEditingController storeNameController;
  Governorate? _selectedGovernorate; // the object of selected governorate
  City? _selectedCity; // the object of the selected city
  late TextEditingController governorateController; // the name of governorate
  late TextEditingController cityController; // the name of governorate
  late TextEditingController addressController;
  late TextEditingController passwordController;

  final List<Widget> signupSteps = [
    const PhoneStep(),
    const OTPStep(),
    const UserTypeStep(),
    const RegisterStep(),
  ];

  void initControllers() {
    pageController = PageController();
    phoneController = TextEditingController();
    usernameController = TextEditingController();
    storeNameController = TextEditingController();
    passwordController = TextEditingController();
    addressController = TextEditingController();
    governorateController = TextEditingController();
    cityController = TextEditingController();
  }

  void disposeControllers() {
    pageController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    storeNameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    governorateController.dispose();
    cityController.dispose();
    _selectedUserType = null;
    _selectedGovernorate = null;
    _selectedCity = null;
    _otp = null;
  }

  String getPhoneNumber() {
    final String _enteredPhoneNumber = phoneController.text;
    final String _phoneNumber =
        _enteredPhoneNumber.substring(_enteredPhoneNumber.length - 10);
    final String _completePhoneNumber = "+20" + _phoneNumber;
    return _completePhoneNumber;
  }

  void onGovernorateSelected(Governorate governorate) {
    _selectedGovernorate = governorate;
    governorateController.text = _selectedGovernorate!.name;
    _selectedCity = null;
    cityController.clear();
  }

  void onCitySelected(City city) {
    _selectedCity = city;
    cityController.text = _selectedCity!.name;
  }

  List<City> getCities(String governorateId) {
    final List<City> _cities = [];
    for (var city in cities) {
      if (city.governorateId == governorateId) {
        _cities.add(city);
      }
    }
    return _cities;
  }

  /// getters
  String? get otp => _otp;

  UserType? get selectedUserType => _selectedUserType;

  Governorate? get selectedGovernorate => _selectedGovernorate;

  City? get selectedCity => _selectedCity;

  /// setters
  void setOTP(String otp) {
    _otp = otp;
  }

  void setSelectedUserType(UserType userType) {
    _selectedUserType = userType;
  }
}
