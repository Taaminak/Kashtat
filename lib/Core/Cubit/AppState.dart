abstract class AppState {
}

class InitState extends AppState{}

class UserState extends AppState{}

class LoadingCityState extends AppState{}
class LoadingPaymentState extends AppState{}
class LoadingHomeTripsState extends AppState{}
class LoadingUserTripsState extends AppState{}
class LoadingProviderTripsState extends AppState{}
class LoadingReserveTripState extends AppState{}

class CategoriesState extends UserState{}
class CategoriesHomeState extends UserState{}
class LoadingCategoriesState extends CategoriesState{}
class SuccessCategoriesState extends CategoriesState{}
class FailureCategoriesState extends CategoriesState{}
class AllCreateUnitCategoryState extends CategoriesState{}

class UserChangedState extends UserState{}

class CitiesState extends AppState{}
class SuccessCitiesState extends CitiesState{}
class FailureCitiesState extends CitiesState{}

class PaymentsState extends AppState{}
class SuccessPaymentsState extends PaymentsState{}
class FailurePaymentsState extends PaymentsState{}

class UserTripsState extends AppState{}
class SuccessTripsState extends UserTripsState{}
class FailureTripsState extends UserTripsState{}

class ProviderTripsState extends AppState{}
class SuccessProviderState extends ProviderTripsState{}
class FailureProviderState extends ProviderTripsState{}

class ReserveTripState extends AppState{}
class SuccessReserveTripState extends ReserveTripState{}
class FailureReserveTripState extends ReserveTripState{
  String msg;
  FailureReserveTripState({required this.msg});
}

class SelectedDatesChanged extends AppState{}

class CreateUnitState extends AppState{}
class UpdateUnitBodyState extends CreateUnitState{}
class LoadingCreateNewUnitState extends CreateUnitState{}
class SuccessCreateUnitState extends CreateUnitState{}
class FailureCreateUnitState extends CreateUnitState{
  String msg;
  FailureCreateUnitState({required this.msg});
}

class UpdateProfileState extends AppState{}
class UpdateProfileSuccessState extends UpdateProfileState{}
class UpdateProfileFailureState extends UpdateProfileState{}
class LoadingUpdateProfileState extends UpdateProfileState{}

class CouponState extends AppState{}

class CreateCouponLoadingState extends CouponState{}
class CreateCouponSuccessState extends CouponState{}
class CreateCouponFailureState extends CouponState{
  String msg;
  CreateCouponFailureState({required this.msg});
}

class GetCouponLoadingState extends CouponState{}
class GetCouponSuccessState extends CouponState{}
class GetCouponFailureState extends CouponState{
  String msg;
  GetCouponFailureState({required this.msg});
}

class ValidateCouponLoadingState extends CouponState{}
class ValidateCouponSuccessState extends CouponState{}
class ValidateCouponFailureState extends CouponState{
  String msg;
  ValidateCouponFailureState({required this.msg});
}


class UpdateUnitState extends AppState{}

class UpdateUnitLoadingAddDatesState extends UpdateUnitState{}
class UpdateUnitLoadingRemoveDatesState extends UpdateUnitState{}
class UpdateUnitSuccessRemoveDatesState extends UpdateUnitState{}
class UpdateUnitFailureRemoveDatesState extends UpdateUnitState{}
class UpdateUnitSuccessAddDatesState extends UpdateUnitState{}
class UpdateUnitFailureAddDatesState extends UpdateUnitState{}

class UpdateUnitLoadingState extends UpdateUnitState{}
class UpdateUnitSuccessState extends UpdateUnitState{}
class UpdateUnitFailureState extends UpdateUnitState{
  String msg;
  UpdateUnitFailureState({required this.msg});
}
class UpdateUnitStatusLoadingState extends UpdateUnitState{}
class UpdateUnitStatusSuccessState extends UpdateUnitState{}
class UpdateUnitStatusFailureState extends UpdateUnitState{
  String msg;
  UpdateUnitStatusFailureState({required this.msg});
}

class UpdateUnitMapLocationLoadingState extends UpdateUnitState{}
class UpdateUnitMapLocationSuccessState extends UpdateUnitState{}
class UpdateUnitMapLocationFailureState extends UpdateUnitState{
  String msg;
  UpdateUnitMapLocationFailureState({required this.msg});
}

class UpdateUnitNameAndDescLoadingState extends UpdateUnitState{}
class UpdateUnitNameAndDescSuccessState extends UpdateUnitState{}
class UpdateUnitNameAndDescFailureState extends UpdateUnitState{
  String msg;
  UpdateUnitNameAndDescFailureState({required this.msg});
}

class ProviderCategoriesWithUnitsState extends AppState{}
class ProviderCategoriesWithUnitsLoadingState extends ProviderCategoriesWithUnitsState{}
class ProviderCategoriesWithUnitsSuccessState extends ProviderCategoriesWithUnitsState{}
class ProviderCategoriesWithUnitsFailureState extends ProviderCategoriesWithUnitsState{
  String msg;
  ProviderCategoriesWithUnitsFailureState({required this.msg});
}


class FinancialSummaryState extends AppState{}
class FinancialSummaryLoadingState extends FinancialSummaryState{}
class FinancialSummarySuccessState extends FinancialSummaryState{}
class FinancialSummaryFailureState extends FinancialSummaryState{
  String msg;
  FinancialSummaryFailureState({required this.msg});
}

class RatingSummaryState extends AppState{}
class RatingSummaryLoadingState extends RatingSummaryState{}
class RatingSummarySuccessState extends RatingSummaryState{}
class RatingSummaryFailureState extends RatingSummaryState{
  String msg;
  RatingSummaryFailureState({required this.msg});
}


class GetBankAccountsState extends AppState{}
class GetBankAccountsLoadingState extends GetBankAccountsState{}
class GetBankAccountsSuccessState extends GetBankAccountsState{}
class GetBankAccountsFailureState extends GetBankAccountsState{
  String msg;
  GetBankAccountsFailureState({required this.msg});
}


class CreateNewBankAccountState extends AppState{}
class CreateNewBankAccountLoadingState extends CreateNewBankAccountState{}
class CreateNewBankAccountSuccessState extends CreateNewBankAccountState{}
class CreateNewBankAccountFailureState extends CreateNewBankAccountState{
  String msg;
  CreateNewBankAccountFailureState({required this.msg});
}


class GetAllBanksState extends AppState{}
class GetAllBanksLoadingState extends GetAllBanksState{}
class GetAllBanksSuccessState extends GetAllBanksState{}
class GetAllBanksFailureState extends GetAllBanksState{
  String msg;
  GetAllBanksFailureState({required this.msg});
}


class CategoryState extends AppState{}
class UpdateCategoryLoadingState extends CategoryState{}
class UpdateCategorySuccessState extends CategoryState{}
class UpdateCategoryFailureState extends CategoryState{
  String msg;
  UpdateCategoryFailureState({required this.msg});
}

class ProfileState extends AppState{}
class LoadingProfileState extends ProfileState{}
class SuccessProfileProfileState extends ProfileState{}
class FailureProfileProfileState extends ProfileState{
}

class WalletState extends AppState{}
class LoadingWalletState extends WalletState{}
class SuccessWalletState extends WalletState{}
class FailureWalletState extends WalletState{
}

