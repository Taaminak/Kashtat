import 'package:flutter/material.dart';

class APIsManager{
  static String baseURL = 'http://137.184.154.60';
  // static String baseURL = 'http://167.71.17.49';

  static String getAllCategories = "/api/categories?page=home";
  static String createNewUnit = "/api/units";
  static String updateUnit = "/api/units";
  static String updateProfile = "/api/profile";
  static String getAllProviderUnits = "/api/provider/units";
  static String validateCoupon = "/api/validate-coupon";
  static String createCoupon = "/api/coupons";
  static String rateReservation = "/api/user/reservations/rating";
  static String getAllCoupons = "/api/coupons";
  static String getFinancialSummary = "/api/financial-summary";
  static String getRatingSummary = "/api/ratings";
  static String getAllBanks= "/api/banks";
  static String getBankAccounts= "/api/bank-accounts";
  static String createNewBankAccount= "/api/bank-accounts";
  static String createNewComplaints= "/api/complaints";
  static String updateCategory= "/api/categories";
}