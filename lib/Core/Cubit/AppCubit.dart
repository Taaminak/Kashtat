import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/APIsManager.dart';
import 'package:kashtat/Core/models/AccountModel.dart';
import 'package:kashtat/Core/models/AllBanksModel.dart';
import 'package:kashtat/Core/models/BankAccountsModel.dart';
import 'package:kashtat/Core/models/BankModel.dart';
import 'package:kashtat/Core/models/CategoryModel.dart';
import 'package:kashtat/Core/models/CitiesModel.dart';
import 'package:kashtat/Core/models/CityModel.dart';
import 'package:kashtat/Core/models/CouponModel.dart';
import 'package:kashtat/Core/models/CouponsModel.dart';
import 'package:kashtat/Core/models/CreateNewUnitCategoryModel.dart';
import 'package:kashtat/Core/models/CreateNewUnitModel.dart';
import 'package:kashtat/Core/models/FinancialSummaryModel.dart';
import 'package:kashtat/Core/models/PaymentMethodsModel.dart';
import 'package:kashtat/Core/models/RequestTripModel.dart';
import 'package:kashtat/Core/models/ReservationModel.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Core/models/UnitsModel.dart';
import 'package:kashtat/Core/models/WalletLogsModel.dart';
import 'package:kashtat/Core/repository/endpoint_responses.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ProviderCategorysWithUnits.dart';
import '../models/RatingModel.dart';
import '../models/RequestTripModel.dart';
import '../models/UserModel.dart';
import '../repository/remote_endpoint_module.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc() : super(InitState());


  NetworkModule request = NetworkModule();
  UserType userType = UserType.isNormal;

  User? userProfile;

  UserReservationModel? userTrips;

  UserReservationModel? providerTrips;

  List<City> allCities = [];

  PaymentMethodsModel? paymentMethods;

  UnitsModel? allTrips;

  UnitsModel? homeTrips;

  RequestTripModel requestTripModel = RequestTripModel();

  List<String> selectedDates = [];

  List<CategoryModel> allCategories = [];
  List<CategoryModel> categoriesWithSubCategories = [];
  List<CategoryModel> categoriesWithoutSubCategories = [];

  List<CreateNewUnitCategoryModel> allCreateUnitCategory = [];

  List<ProviderCategoriesWithUnits> providerCategoriesWithUnits = [];

  List<CouponModel> allCoupons = [];

  CreateUnitBody unitBody = CreateUnitBody();

  Future<void> initAppData() async {
      getUserProfile();
      getHomeTrips();
      getAllCategories();
      await getAllCities();
     // getAllPayments();
  }
  setSelectedDates(List<String> dates){
    selectedDates = [];
    selectedDates = dates;
    emit(SelectedDatesChanged());

  }

  shuffleHomeUnites(){
    if(homeTrips!=null){

      homeTrips!.data?.shuffle();
    }
    // homeTrips =homeTrips!.copyWith(
    //   data: ,
    // );

    // print(homeTrips!.data.first.id);
    emit(SuccessTripsState());
  }

  changeUserType(UserType userType) {
    this.userType = userType;
    emit(UserChangedState());
  }

  Future<void> getUserProfile() async {
    emit(LoadingProfileState());
    final result = await request.getRequest('/api/profile');
    result.fold((failure) {
      emit(FailureProfileProfileState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      userProfile = User.fromJson(decodedData['data']);
      emit(SuccessProfileProfileState());
    });
  }


  Future<void> getAllCities() async {
    emit(LoadingCityState());
    final result = await request.getRequest('/api/cities');
    result.fold((failure) {
      emit(FailureCitiesState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      final cities = CitiesModel.fromJson(decodedData);
      allCities = cities.data;
      emit(SuccessCitiesState());
    });
  }

  Future<void> getAllPayments() async {
    emit(LoadingPaymentState());
    final result = await request.getRequest('/api/payment-gateways');

    result.fold((failure) {
      emit(FailurePaymentsState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      paymentMethods = PaymentMethodsModel.fromJson(decodedData);
      emit(SuccessPaymentsState());
    });
  }

  filterUsingCityId(int? cityId){
    try{
      if(cityId == null){
        homeTrips = allTrips;
      }else{

        List<UnitModel>? trips = allTrips?.data?.where((unit) => unit.city!.id == cityId).toList();
        homeTrips = homeTrips?.copyWith(
            data: trips?? []
        );
      }
      emit(SuccessTripsState());
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(FailureTripsState());
    }

    if (kDebugMode) {
      print(homeTrips?.data?.length);
    }
  }

  Future<void> getHomeTrips({/*List<String>? dates, */int? cityId}) async {
    emit(LoadingHomeTripsState());

    // try{

      String url = "/api/units";
      if(cityId !=null){
        url+="?city_id=$cityId";
      }

      final result = await request.getRequest(url);

      result.fold((failure) {
        emit(FailureTripsState());
      }, (result) {
        final decodedData = json.decode(result.data.toString());
        allTrips = UnitsModel.fromJson(decodedData);
        homeTrips = allTrips;
        emit(SuccessTripsState());
      });
    // }catch(e){
    //   debugPrintStack(label: e.toString());
    //   emit(FailureTripsState());
    // }
  }


    filterHomeUnitsByCategory({required int catId, int? subCatId}){
      setHomeItems(homeTrips!.copyWith(
          data: allTrips!.data?.where((trip) => subCatId != null?/*trip.category!.id == catId && */trip.subCategory!.id == subCatId :trip.category!.id == catId).toList()
      ));
      emit(SuccessTripsState());
    }



  setHomeItems(UnitsModel trips ){
    homeTrips = trips;
    emit(SuccessTripsState());
  }
  void setReserveTripData({required UnitModel unit}) {
    print(unit.toJson());
    requestTripModel = RequestTripModel(
      notes: "Trip Notes",
      subtotal: calculatePrice(selectedDates, unit.price??Price()).total,
      total: calculatePrice(selectedDates, unit.price??Price()).total + (calculatePrice(selectedDates, unit.price??Price()).total*0.15),
      arrivalDateTime: selectedDates.first,
      leavingDateTime: selectedDates.last,
      cityId: unit.state!.id,
      latitude: unit.latitude,
      longitude: unit.longitude,
      numberOfPersons: unit.capacity,
      // paymentGatewayId: trip.paymentGateway.id,
      unitId: unit.id,
      vat: calculatePrice(selectedDates, unit.price??Price()).total*0.15,
    );
  }

  RequestTripModel get getReserveTripData => requestTripModel;

  Future<void> reserveTrip({required double total, required double subtotal, required double vat, required List<int> paymentMethods, double? walletAmount}) async {

    var body = {
      "unit_id":getReserveTripData.unitId,
      "arrival_date_time":selectedDates.first,
      "leaving_date_time":selectedDates.last,
      "total":total,
      "subtotal":subtotal,
      "vat":vat,
      "payment_methods[0]":paymentMethods.first.toString(),
      if(walletAmount!= null) "deducted_wallet_amount":walletAmount
    };

    try{
      emit(LoadingReserveTripState());
      final result = await request.postRequest('/api/user/reservations', body, true);
      result.fold((failure) {
        throw Exception(failure);
      }, (result) {
        emit(SuccessReserveTripState());
        getHomeTrips();
        getUserProfile();
      });
    }catch(e){
      emit(FailureReserveTripState(msg: e.toString()));
    }
  }

  Future<void> getUserTrips() async {
    emit(LoadingUserTripsState());
    final result = await request.getRequest('/api/user/reservations');

    result.fold((failure) {
      emit(FailureTripsState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      UserReservationModel? userTripsResponse = UserReservationModel.fromJson(decodedData);
      userTrips = userTripsResponse;
      emit(SuccessTripsState());
    });
  }
  ReservationModel? lastTrip;
  Future<void> getLastTrip() async {
    emit(LoadingUserTripsState());
    final result = await request.getRequest('/api/user/last-reservation');

    result.fold((failure) {
      emit(FailureTripsState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      lastTrip = ReservationModel.fromJson(decodedData['data']);
      emit(SuccessTripsState());
    });
  }


  /// create Coupon
  Future<void> rateReservation({required  int rating})async{
    emit(UpdateUnitLoadingState());
    try{
      final result = await request.postRequest(APIsManager.rateReservation,{
        "rating":rating
      });
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        print(result.data);
        getLastTrip();
        emit(UpdateUnitSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(UpdateUnitFailureState(msg: e.toString()));
    }
  }

  Future<void> getProviderTrips() async {
    emit(LoadingProviderTripsState());
    final result = await request.getRequest('/api/provider/reservations');
    result.fold((failure) {
      emit(FailureProviderState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      providerTrips = UserReservationModel.fromJson(decodedData);
      emit(SuccessProviderState());
    });
  }
  List<UnitModel> allProviderUnits = [];
  Future<void> getAllProviderUnitsInOneLevel() async {
    emit(LoadingProviderTripsState());
    final result = await request.getRequest('/api/provider/units?level=1');
    result.fold((failure) {
      emit(FailureProviderState());
    }, (result){
      final decodedData = json.decode(result.data.toString());
      allProviderUnits = (decodedData['data'] as List).map((e) => UnitModel.fromJson(e)).toList();
      emit(SuccessProviderState());
    });
  }

  Future<void> getAllCategories({int? cityId})async{
    emit(LoadingCategoriesState());
    try{
      String url = APIsManager.getAllCategories;
      if(cityId !=null){
        url += "&city_id=$cityId";
      }
      final result = await request.getRequest(url);
      result.fold((failure) {
        throw Exception(failure);
      }, (result) {
        final decodedData = json.decode(result.data.toString());
        allCategories = List<CategoryModel>.from(decodedData['data'].map((category)=>CategoryModel.fromJson(category)));
        createHomeCategories();
        setNewUnitCategoryList();
        emit(SuccessCategoriesState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      allCategories = [];
      emit(FailureCategoriesState());
    }
  }

  void createHomeCategories(){
    categoriesWithSubCategories = [];
    categoriesWithoutSubCategories = [];
    for (var c in allCategories){
      if(c.subCategories!.isNotEmpty){
        categoriesWithSubCategories.add(c);
      }else{
        categoriesWithoutSubCategories.add(c);
      }
    }
    emit(CategoriesHomeState());
  }

  void setNewUnitCategoryList(){
    allCreateUnitCategory = [];
    for (var e in allCategories) {
      if(e.subCategories!.isEmpty){
        final sub = CreateNewUnitCategoryModel(name:e.name! , img: e.img!, serviceText: e.serviceName!, categoryId: e.id!);
         allCreateUnitCategory.add(sub);
      }else{
        List<CreateNewUnitCategoryModel> subCat = [];
        for (var c in e.subCategories!) {
          final sub =  CreateNewUnitCategoryModel(name:c.name! , img: c.img!, serviceText: c.serviceName!, categoryId: e.id!, subCategoryId: c.id);

          allCreateUnitCategory.add(sub);
        }
      }
    }
    emit(AllCreateUnitCategoryState());
  }

  String getCategoryServiceName(int categoryId, int? subCategoryId){
    String serviceName = '';
    try{
      serviceName = allCreateUnitCategory.firstWhere((category) => category.categoryId == categoryId && category.subCategoryId == subCategoryId).serviceText;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    return serviceName;
  }


  /// pick ( single image or multi image ) from gallery based on type ( ImagePickerType.singleImage or ImagePickerType.multiImages )
  Future<List<XFile>> pickImage(ImagePickerType type)async{
    final ImagePicker picker = ImagePicker();
    if(type == ImagePickerType.singleImage){
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if(image != null){
        final bytes = await image!.length();
        final kb = bytes / 1024;
        final mb = kb / 1024;
        print('===============');
        print("bytes: $bytes");
        print("kb: $kb");
        print("mb: $mb");
        print('===============');
        return [image];
      }
    }else{
      final List<XFile> images = await picker.pickMultiImage();
      images.forEach((image) async{
        final bytes = await image.length();
        final kb = bytes / 1024;
        final mb = kb / 1024;
        print('===============');
        print(bytes);
        print(kb);
        print(mb);
        print('===============');});
      return images;
    }
    return [];
  }


  // ---------------- create new unit start ----------------

  /// for view selected unit pics only
  List<XFile> otherPics = [];
  /// for view selected unit main pic only
  XFile? mainPic;

  /// update unit request body
  void updateUnitBody(CreateUnitBody body){
    unitBody = body;
    debugPrint(unitBody.toJson().toString());
    emit(UpdateUnitBodyState());
  }

  /// clear unit request body
  void clearUnitBody(){
    unitBody = CreateUnitBody();
    otherPics = [];
    mainPic = null;
    instructionImage = null;
    emit(UpdateUnitBodyState());
  }

  /// unit category, sub-category and title
  void updateNewUnitCategoryAndTitle({
    required int catId,
    required int? subCatId,
  }){
    updateUnitBody(unitBody.copyWith(categoryId: catId, subCategoryId: subCatId));
  }

  /// unit location
  void updateNewUnitLocation({
    // required int stateId,
    required double latitude,
    required double longitude,
    // required int capacity,
  }){
    updateUnitBody(unitBody.copyWith(latitude: latitude,longitude: longitude));
  }

  /// unit city and capacity
  void updateNewUnitStateAndCapacity({
    required int stateId,
    required int capacity,
  }){
    updateUnitBody(unitBody.copyWith(stateId: stateId, capacity: capacity));
  }

  /// unit description
  void updateNewUnitDescription({
    required String name,
    required String desc,
  }){
    updateUnitBody(unitBody.copyWith(description: desc,name: name));
  }

  /// unit Pricing
  void updateNewUnitPricing({
    required int priceOfOthers,
    required int priceFriday,
    required int priceSaturday,
    required int priceThursday,
  }){
    updateUnitBody(unitBody.copyWith(priceOthers: priceOfOthers,priceFriday: priceFriday,priceSaturday: priceSaturday,priceThursday: priceThursday));
  }

  /// Unit main pic
  Future<void> updateNewUnitMainPhotos(XFile image)async{
    MultipartFile file = await MultipartFile.fromFile(image.path, filename: DateTime.now().toString());
    mainPic = image;
    emit(UpdateUnitBodyState());
    updateUnitBody(unitBody.copyWith(mainPic: file));
  }

  /// unit reservation role
  void updateNewUnitReservationRole({
    required String reservationRole,
  }){
    updateUnitBody(unitBody.copyWith(reservationRoles: reservationRole));
  }

  /// unit reservation role
  void updateNewUnitCancellation({
    required String cancellation,
  }){
    updateUnitBody(unitBody.copyWith(cancellationPolicy: cancellation));
  }

  /// unit times
  void updateNewUnitTime({
    required String arrival,
    required String leaving,
  }){
    updateUnitBody(unitBody.copyWith(arrivalDate: arrival,leavingDate: leaving));
  }

  /// unit instructions
  void updateNewUnitInstructions({
    required String inst1,
    required String inst2,
  }){
    updateUnitBody(unitBody.copyWith(instruction1: inst1,instruction2: inst2));
  }

  XFile? instructionImage;
  /// Unit instruction image
  Future<void> updateNewUnitInstructionPhotos(XFile image)async{
    MultipartFile file = await MultipartFile.fromFile(image.path, filename: DateTime.now().toString());
    instructionImage = image;
    emit(UpdateUnitBodyState());
    updateUnitBody(unitBody.copyWith(instructionImage: file));
  }

  /// Unit pics
  Future<void> updateNewUnitPhotos(List<XFile> images)async{
    List<MultipartFile> files =[];
    for (var e in images) {
      var file = await MultipartFile.fromFile(e.path, filename: DateTime.now().toString());
      files.add(file);
    }
    otherPics = images;
    emit(UpdateUnitBodyState());
    updateUnitBody(unitBody.copyWith(pics: files));
  }

  Future<void> createNewUnit()async{
    emit(LoadingCreateNewUnitState());
    try{
      print(unitBody.toJson());
      final body = FormData.fromMap(unitBody.toJson());
      final result = await request.postRequest(APIsManager.createNewUnit,body,true);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        clearUnitBody();

        emit(SuccessCreateUnitState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(FailureCreateUnitState(msg: e.toString()));
    }

  }
// ---------------- create new unit end ----------------


  Future<void> updateProfile({
    required String phone,
    required String name,
    required XFile? avatar,
  })async{
    emit(LoadingUpdateProfileState());
      final result = await request.postRequest(APIsManager.updateProfile, 
      FormData.fromMap({
        "phone": phone,
        "name": name,
        if(avatar !=null)
        "avatar": await MultipartFile.fromFile(avatar.path, filename: DateTime.now().toString()),
      }));
      result.fold((failure) {
        throw Exception(failure);
      }, (data) async {
        print(data.data);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final decodedData = json.decode(data.data.toString());
        // print(decodedData['data']['avatar']);
        prefs.setString('avatar', decodedData['data']['avatar'].toString());
        prefs.setString('name', decodedData['data']['name'].toString());
        prefs.setString('phone', decodedData['data']['phone'].toString());
        prefs.setString('avatar', decodedData['data']['avatar'].toString());
        emit(UpdateProfileSuccessState());
      });
    // }catch(e){
    //   debugPrintStack(label: e.toString());
    //   emit(UpdateProfileFailureState());
    // }
  }

  /// provider units
  Future<void> getAllProviderUnits()async{
    emit(ProviderCategoriesWithUnitsLoadingState());
    await getAllCategories();
    try{
      final result = await request.getRequest(APIsManager.getAllProviderUnits);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        providerCategoriesWithUnits = [];
        parseUnitsProvider(result.data.toString());
        emit(ProviderCategoriesWithUnitsSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(ProviderCategoriesWithUnitsFailureState(msg: e.toString()));
    }
  }

  CategoryModel getCategoryById(int id)=>allCategories.firstWhere((element) => element.id==id);

  void parseUnitsProvider(String data){
    try{
      providerCategoriesWithUnits.clear();
      Map mapValue = json.decode(data);
      List<UnitModel> units = [];
      int categoryId = -1;
      mapValue['data'].forEach((item) {
        item.forEach((key,value){
          if(key == 'id'){
            categoryId = value;
          }else{
            units = [];
            value.forEach((unit) {
              units.add(UnitModel.fromJson(unit));
            });
            providerCategoriesWithUnits.add(ProviderCategoriesWithUnits(name: key, units: units,categoryId: categoryId));
          }});
      });
    }catch(e){
      print(e);
    }
    emit(ProviderCategoriesWithUnitsSuccessState());
  }

  /// update provider unit
  Future<bool> updateUnit({required int unitId,required dynamic body, bool isPostMethod = false})async{
    // emit(UpdateUnitLoadingState());
    bool isSuccess = false;
    Either<Failure, Success> result;

    if(isPostMethod){
      result = await request.postRequest('${APIsManager.updateUnit}/$unitId',body,true);
    }else{
      result = await request.putRequest('${APIsManager.updateUnit}/$unitId',body,true);
    }

    result.fold((failure) {
      // emit(UpdateUnitFailureState(msg: failure.toString()));
      isSuccess= false;
    }, (result) {
      final data = jsonDecode(result.data.toString());
      UnitModel unit = UnitModel.fromJson(data['data']);
      setSelectedUnit(unit);
      clearUnitBody();
      isSuccess = true;
    });
    return isSuccess;
  }

  bool unitStatus = false;
  Future updateUnitStatus({required bool status, required int unitId})async{
    unitStatus = status;
    Object body = updateBodyData(UpdateType.status);
    emit(UpdateUnitStatusLoadingState());
    await updateUnit(unitId: unitId, body: body).then((value){
      if(value){
        emit(UpdateUnitStatusSuccessState());
        setSelectedUnit(selectedUnit.copyWith(isActive: status));
        getAllProviderUnits();
      }else{
        emit(UpdateUnitStatusFailureState(
          msg: 'Failed in change status.'
        ));
      }
    });
  }

  Future updateUnitCategories({required int unitId})async{
    Object body = updateBodyData(UpdateType.categories);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: unitId, body: body);
    getAllProviderUnits();
  }

  //123
  Future updateUnitPricing()async{
    Object body = updateBodyData(UpdateType.pricing);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: selectedUnit.id!, body: body);
    getAllProviderUnits();
  }
  //123
  Future updateUnitTimes()async{
    Object body = updateBodyData(UpdateType.times);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: selectedUnit.id!, body: body,isPostMethod: true);
    getAllProviderUnits();
  }
  //123
  Future updateUnitReturnAndCancellationPolicy()async{
    Object body = updateBodyData(UpdateType.returnAndCancellationPolicy);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: selectedUnit.id!, body: body);
    getAllProviderUnits();
  }
  //123
  Future updateUnitReservationRoles()async{
    Object body = updateBodyData(UpdateType.reservationRoles);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: selectedUnit.id!, body: body);
    getAllProviderUnits();
  }
  //123
  Future updateUnitArrivalInstructions()async{
    Object body = updateBodyData(UpdateType.arrivalInstructions);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: selectedUnit.id!, body: body,isPostMethod: true);
    getAllProviderUnits();
  }

  Future updateUnitCityAndState({required int unitId})async{
    Object body = updateBodyData(UpdateType.cityAndState);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: unitId, body: body).then((value) => getAllProviderUnits());
  }

  Future updateUnitMapLocation({required int unitId})async{
    Object body = updateBodyData(UpdateType.mapLocation);
    emit(UpdateUnitMapLocationLoadingState());
    await updateUnit(unitId: unitId, body: body).then((value){
      if(value){
        getAllProviderUnits();
        emit(UpdateUnitMapLocationSuccessState());
      }else{
        emit(UpdateUnitMapLocationFailureState(msg: 'Failed To update unit location.'));
      }
    });
  }

  Future updateUnitNameAndDetails({required int unitId})async{
    Object body = updateBodyData(UpdateType.nameAndDetails);
    emit(UpdateUnitNameAndDescLoadingState());
    await updateUnit(unitId: unitId, body: body).then((success)async{
      if(success){
        getAllProviderUnits();
        emit(UpdateUnitNameAndDescSuccessState());
      }else{
        emit(UpdateUnitNameAndDescFailureState(msg: 'Failed to update name and description'));
      }
    });
  }

  Future updateUnitPhotos({required int unitId})async{
    Object body = updateBodyData(UpdateType.photos);
    emit(UpdateUnitLoadingState());
    await updateUnit(unitId: unitId, body: body,isPostMethod: true).then((value) => getAllProviderUnits());
    clearUnitBody();
  }

  Future updateUnitReservedDates({required int unitId,required bool isAdd, required List<String> dates})async{
    Map<String,String> body = {};
    for(int i = 0; i<dates.length ; i++){
      body["reservations_dates[$i]"] = dates[i];
    }
    if(isAdd){
      emit(UpdateUnitLoadingAddDatesState());
    }else{
      emit(UpdateUnitLoadingRemoveDatesState());
    }
    await updateUnit(unitId: unitId, body: body).then((value)async{
      if(value){
        await getAllProviderUnits();
      }
      if(isAdd){
        if(value){
          addDates(selectedUnit.reservedDates??[], dates);
          setSelectedUnit(selectedUnit.copyWith(reservedDates: reservedDates));
          emit(UpdateUnitSuccessAddDatesState());
        }else {
          emit(UpdateUnitFailureAddDatesState());
        }
      }else{
        if(value){
          removeDates(selectedUnit.reservedDates??[], dates);
          setSelectedUnit(selectedUnit.copyWith(reservedDates: reservedDates));
          emit(UpdateUnitSuccessRemoveDatesState());
        }else {
          emit(UpdateUnitFailureRemoveDatesState());
        }
      }

    });
  }

  List<String> updatedReservedDates = [];

  List<String> get reservedDates=> updatedReservedDates;

  void setReservedDates({required List<String> dates})async{
    updatedReservedDates = dates;
  }

  void addDates(List<String> currentDates, List<String> newDates){
    currentDates.addAll(newDates);
    setReservedDates(dates: currentDates);
  }

  void removeDates(List<String> currentDates, List<String> newDates){
    List<String> filteredDates = [];
    for (String date in currentDates) {
      if(!newDates.contains(date)){
        filteredDates.add(date);
      }
    }
    setReservedDates(dates: filteredDates);
  }

  UnitModel _selectedUnit = UnitModel();

  setSelectedUnit(UnitModel unit){
    _selectedUnit = unit;
    log(_selectedUnit.toJson().toString());
    emit(UpdateUnitState());
  }

  UnitModel get selectedUnit => _selectedUnit;


  /// create update body request based on update type
  dynamic updateBodyData(UpdateType type){
    if(type == UpdateType.status){
       return {
        "is_active": unitStatus?1:0,
      };
    }else if(type == UpdateType.categories){
      return {
        "category_id":unitBody.categoryId,
        if(unitBody.subCategoryId != null)
          "sub_category_id":unitBody.subCategoryId
      };
    }else if(type == UpdateType.cityAndState){
      return {
        "state_id":unitBody.stateId
      };
    }else if(type == UpdateType.mapLocation){
      return {
        "latitude":unitBody.latitude,
        "longitude":unitBody.longitude
      };
    }else if(type == UpdateType.nameAndDetails){
      return {
        "name":unitBody.name,
        "description":unitBody.description
      };
    }else if(type == UpdateType.photos){
      Map<String, dynamic> json = {};
      json['_method'] = "PUT";
      json["main_pic"] =  unitBody.mainPic;
      if(unitBody.pics != null){
        for(int i = 0; i<unitBody.pics!.length ; i++){
          json['pics[$i]'] = unitBody.pics![i];
        }
      }
      return FormData.fromMap(json);
    }else if(type == UpdateType.dates){
      return {
        "reservations_dates": reservedDates
      };
    }else if(type == UpdateType.pricing){
      return {
        "price[thursday]": unitBody.priceThursday,
        "price[friday]": unitBody.priceFriday,
        "price[saturday]": unitBody.priceSaturday,
        "price[others]": unitBody.priceOthers,
      };
    }else if(type == UpdateType.times){
      return {
        "_method":"PUT",
        "check_in": unitBody.arrivalDate,
        "check_out": unitBody.leavingDate,
      };
    }else if(type == UpdateType.returnAndCancellationPolicy){
      return {
        "_method":"PUT",
        "cancellation_and_refund_policy": unitBody.cancellationPolicy,
      };
    }else if(type == UpdateType.reservationRoles){
      return {
        "_method":"PUT",
        "reservations_terms": unitBody.reservationRoles,
      };
    }else if(type == UpdateType.arrivalInstructions){
      return FormData.fromMap({
        "_method":"PUT",
        "arrival_policy": unitBody.instruction1,
        "other_arrival_policy": unitBody.instruction2,
        "arrival_policy_pic": unitBody.instructionImage,
      });
    }else {
      return {};
    }

  }

  /// get all Coupon
  Future<void> getAllCoupons()async{
    emit(CreateCouponLoadingState());
    try{
      final result = await request.getRequest(APIsManager.getAllCoupons);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        final data = json.decode(result.data.toString());
        CouponsModel coupons = CouponsModel.fromJson(data);
        allCoupons = coupons.data ??[];
        emit(CreateCouponSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      allCoupons = [];
      emit(CreateCouponFailureState(msg: e.toString()));
    }
  }

  /// create Coupon
  Future<bool> createCoupon({required  FormData body})async{
    emit(CreateCouponLoadingState());
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token') ;
      final dio = Dio();
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        "Keep-Alive": "timeout=5, max=1000",
        if (token != null)'Authorization': 'Bearer $token',
      };

      final response = await dio.post('http://137.184.154.60/api/coupons',data: body);
      if(response.statusCode! <300){
        getAllCoupons();
        emit(CreateCouponSuccessState());
        return true;
      }else{
        throw Exception(response.data);
      }

    }catch(e){
      debugPrintStack(label: e.toString());
      emit(CreateCouponFailureState(msg: e.toString()));
      return false;
    }
  }

  /// validate Coupon
  Future<int> validateCoupon({required String code, required int unitId})async{
    emit(ValidateCouponLoadingState());
    int value = 0;
    try{
      final formData = FormData.fromMap({
        "unit_id": unitId,
        "code": code,
      });
      final result = await request.postRequest(APIsManager.validateCoupon,formData);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        print(result.data);
        final data = jsonDecode(result.data.toString());
        CouponModel coupon = CouponModel.fromJson(data['data']);
        emit(ValidateCouponSuccessState());
        value =  coupon.discount??0;
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(ValidateCouponFailureState(msg: e.toString()));

    }
    return value;
  }

  // start financial methods
  FinancialData financialData = FinancialData();
  /// Financial Summary.
  Future<void> getFinancialSummary({String? from, String? to, int? unitId, int? categoryId})async{
    emit(FinancialSummaryLoadingState());
    try{
      String params = '';
      if(from !=null){
        params +='date_from=${from.convertToEnglishDate()}&';
      }
      if(to !=null){
        params +='date_to=${to.convertToEnglishDate()}&';
      }
      if(unitId !=null){
        params +='unit_id=$unitId&';
      }
      if(categoryId !=null){
        params +='category_id=$categoryId&';
      }
      print(params);
      final result = await request.getRequest("${APIsManager.getFinancialSummary}?$params");
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        final data = json.decode(result.data.toString());
        final financial = FinancialSummaryModel.fromJson(data);
        financialData = financial.data ?? FinancialData();
        emit(FinancialSummarySuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      financialData = FinancialData();
      emit(FinancialSummaryFailureState(msg: e.toString()));
    }
  }

  List<BankAccountModel> bankAccounts = [];
  /// Bank Accounts
  Future<void> getBankAccounts()async{
    emit(GetBankAccountsLoadingState());
    try{
      final result = await request.getRequest(APIsManager.getBankAccounts);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        final data = json.decode(result.data.toString());
        final accounts = BankAccountsModel.fromJson(data);
        bankAccounts = accounts.data??[];
        emit(GetBankAccountsSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      bankAccounts = [];
      emit(GetBankAccountsFailureState(msg: e.toString()));
    }
  }

  /// Create a new bank account
  Future<void> createNewBankAccount({required String name, required String iban, required int bankId})async{
    emit(CreateNewBankAccountLoadingState());
    try{
      final result = await request.postRequest(APIsManager.createNewBankAccount,{
        "name": name,
        "iban":iban,
        "bank_id": bankId
      });
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        emit(CreateNewBankAccountSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(CreateNewBankAccountFailureState(msg: e.toString()));
    }
  }


  List<BankModel> allBanks = [];
  /// Get All Banks
  Future<void> getAllBanks()async{
    emit(GetAllBanksLoadingState());
    try{
      final result = await request.getRequest(APIsManager.getAllBanks);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        final data = json.decode(result.data.toString());
        AllBanksModel banks = AllBanksModel.fromJson(data);
        allBanks = banks.data??[];
        emit(GetAllBanksSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      allBanks = [];
      emit(GetAllBanksFailureState(msg: e.toString()));
    }
  }

  /// Create a new complain
  Future<void> createNewComplain({required String message})async{
    emit(CreateNewBankAccountLoadingState());
    try{
      final result = await request.postRequest(APIsManager.createNewComplaints,{
        "message": message,
        "user_type":userType == UserType.isNormal?"normal":"provider"
      });
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        emit(CreateNewBankAccountSuccessState());
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(CreateNewBankAccountFailureState(msg: e.toString()));
    }
  }
  /// Update category
  Future<void> updateCategory({required int categoryId,required Map<String,dynamic> body})async{
    emit(UpdateCategoryLoadingState());
    try{
      final result = await request.postRequest("${APIsManager.updateCategory}/$categoryId",body);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        emit(UpdateCategorySuccessState());
        getAllCategories();
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(UpdateCategoryFailureState(msg: e.toString()));
    }
  }
  List<WalletLogsModel> walletLogs = [];
  Future<void> getWalletLogs()async{
    emit(LoadingWalletState());
    final result = await request.getRequest('/api/wallet-logs');
    result.fold((failure) {
      emit(FailureWalletState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      walletLogs = WalletsModel.fromJson(decodedData).data??[];
      emit(SuccessWalletState());
    });
  }
  List<RateItemModel> rates = [];
  int totalRate = 0;
  /// Rating Summary.
  Future<void> getRatingSummary({int? unitId})async{
    emit(RatingSummaryLoadingState());
    String params = 'limit=10&';
    if(unitId !=null){
      params +='unit_id=$unitId';
    }
    final result = await request.getRequest("${APIsManager.getRatingSummary}?$params");
    result.fold((failure) {
      rates = [];
      totalRate = 0;
      emit(RatingSummarySuccessState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      RateModel rating = RateModel.fromJson(decodedData);
      rates = rating.data??[];
      int sum=0;
      for (var rate in rates) {
        sum+=rate.rating??0;
      }
      if(rates.isNotEmpty){
      totalRate = (sum/rates.length).round();
      }
      emit(RatingSummarySuccessState());
      // emit(SuccessWalletState());
    });

    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token') ;
    // final dio = Dio();
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Connection': 'keep-alive',
    //   'Accept-Encoding': 'gzip, deflate, br',
    //   "Keep-Alive": "timeout=5, max=1000",
    //   if (token != null)'Authorization': 'Bearer $token',
    // };
    //
    // String params = 'limit=10&';
    // if(unitId !=null){
    //   params +='unit_id=$unitId';
    // }
    // print("${APIsManager.getRatingSummary}?$params");
    // final response = await dio.get("${APIsManager.getRatingSummary}?$params");
    // List<dynamic> parsedData = response.data;
    //
    // // Processing the parsed data
    // List<Map<String, dynamic>> parsedList = List<Map<String, dynamic>>.from(parsedData);
    //
    // rates = [];
    // // Accessing parsed data
    // for (var item in parsedList) {
    //   rates.add(RateItemModel.fromJson(item));
    // }
    // for (var element in rates) {
    //   print(element.toJson());
    // }
    // emit(RatingSummarySuccessState());
  }
}


enum UserType {
  isNormal,
  isProvider,
}

enum ImagePickerType{
  singleImage,
  multiImages
}
