// import 'dart:convert';
//
// import '../models/AuthModels/LoginSuccess.dart';
// import '../models/AuthModels/RegistrationFailure.dart';
// import '../models/AuthModels/RegistrationSuccess.dart';
//
//
// dynamic parserBase(dynamic bodyString, dynamic model) {
//   switch (model) {
//     case LoginSuccessModel:
//       return LoginSuccessModel.fromJson(bodyString);
//     case RegistrationModel:
//       return RegistrationModel.fromJson(bodyString);
//     case RegistrationFailureModel:
//       return RegistrationFailureModel.fromJson(bodyString);
//     default:
//       throw Exception('Invalid model name: $model');
//   }
// }