import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Features/Dashboard%20Screen/DashboardScreen.dart';
import 'package:kashtat/Features/Request%20Details/Widgets/RequestDetailsWidget.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'dart:ui' as ui;
import '../../Core/Cubit/AppState.dart';
import '../../Core/Extentions/extention.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../Map Screen/MapScreen.dart';
import '../Widgets/Loader.dart';
import 'Widgets/ShowModelBottomSheet.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({Key? key, required this.trip}) : super(key: key);
  final UnitModel trip;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  int _selectedPayment = 0;
  List<Widget> selectedType = [];
  List<Widget> selectedTypeView = [];
  TextEditingController controller = TextEditingController();
  int discountPercentage = 0;
  double subtotalPrice = 0.0;
  double walletDiscount = 0.0 ;
  bool _checked = false;
  @override
  void initState() {
    buildPayments();
    final cubit = BlocProvider.of<AppBloc>(context);
    calculateOrderPrice();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
      calculateOrderPrice();
    });
    super.initState();
  }
  changeSelected(int i){
    // final cubit = BlocProvider.of<AppBloc>(context);
    // cubit.setReserveTripData(trip: widget.trip);
    setState(() {
      _selectedPayment = i;
    });
  }

  buildPayments(){
    final cubit = BlocProvider.of<AppBloc>(context);
    setState(() {
      selectedType =  [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Image.asset(
                  ImageManager.applePay,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'Apple Pay',
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Image.asset(
                  ImageManager.credit,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'Cridet card or Mada card',
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
          ],
        ),
      ];
      selectedTypeView =  [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'Apple Pay',
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Image.asset(
                  ImageManager.applePay,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                'Cridet card or Mada card',
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Image.asset(
                  ImageManager.credit,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ];
    });
  }
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset(
                ImageManager.logoHalfGrey,
                height: size.height / 2.5,
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).viewPadding.top + 15,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                ImageManager.backIcon,
                                width: 10,
                              ),
                            )),
                      ),
                      // const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageManager.logoWithTitleHColored,
                          width: 150,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child:Container(

                                  decoration: BoxDecoration(
                                    color: ColorManager.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  height: 130,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.trip.mainPic??'',
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Loader(),
                                            errorWidget: (context, url, error) => Icon(Icons.error),

                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.trip.name??'',
                                                style: TextStyle(
                                                  fontSize: FontSize.s18,
                                                  fontWeight:
                                                  FontWeightManager.bold,
                                                ),
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  for (int i = 0; i < 5; i++)
                                                    Padding(
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Icon(
                                                        Icons.star,
                                                        color: (i+1)>widget.trip.rate!.round()?Colors.grey:ColorManager.yellowColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text(
                                                      widget.trip.rate!.toString(),
                                                      style: TextStyle(
                                                        fontSize: FontSize.s14,
                                                        fontWeight:
                                                        FontWeightManager
                                                            .bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 0),
                                              Row(
                                                children: [
                                                  Image.asset(ImageManager.marker,
                                                      color: Colors.black,
                                                      width: 12),
                                                  const SizedBox(width: 5),
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(showSelectLocation: false,lat: widget.trip.latitude??0.0,long: widget.trip.longitude??0.0,)));
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 3.0),
                                                      child: Text(
                                                        widget.trip.city?.name??'',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: FontSize.s12,
                                                          fontWeight: FontWeightManager.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 3.0),
                                                    child: Text('كود الوحدة (${widget.trip.id})',
                                                      style: TextStyle(
                                                        color: ColorManager.blackColor,
                                                        fontSize: FontSize.s12,
                                                        fontWeight: FontWeightManager.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 30),
                                child: Text(
                                  "اختر طريقة الدفع",
                                  style: TextStyle(
                                    fontSize: FontSize.s18,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      selectedTypeView[_selectedPayment],
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          customBottomSheet(
                                              context, LocaleKeys.select_payment_method.tr(),Directionality(
                                            textDirection: ui.TextDirection.ltr,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                color:
                                                ColorManager.whiteDarkColor,
                                                borderRadius:
                                                const BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(50.0),
                                                  topRight:
                                                  Radius.circular(50.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 30.0),
                                                child: Column(
                                                  children:[
                                                    SizedBox(height: 50),
                                                    for(int i=0; i<selectedType.length;i++)
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Radio(
                                                                value: i,
                                                                activeColor: ColorManager
                                                                    .mainlyBlueColor,
                                                                groupValue: _selectedPayment,
                                                                onChanged:
                                                                    (int? value) {
                                                                  print(i);
                                                                  changeSelected(i);
                                                                  context.pop();
                                                                },
                                                              ),
                                                              selectedType[i]
                                                            ],
                                                          ),
                                                          if(i!=selectedType.length-1)
                                                            Divider(thickness: 1.5,)
                                                        ],
                                                      ),
                                                    SizedBox(height: 50),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),true);
                                        },
                                        child: Text(
                                          LocaleKeys.change.tr(),
                                          style: TextStyle(
                                            color: ColorManager.orangeColor,
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: Row(
                                        children: [
                                          const Text(
                                            'استخدم رصيد المحفظة',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeightManager.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              "(${(cubit.userProfile!.wallet! - walletDiscount).toString()} ر.س)",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeightManager.bold,
                                                color: ColorManager.green,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ),
                                      AdvancedSwitch(
                                        controller: _controller,
                                        inactiveColor: Colors.grey.withOpacity(0.5),
                                        activeColor: ColorManager.green,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'إضافة كوبون',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeightManager.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        ImageManager.coupon,
                                        width: 25,
                                        color: ColorManager.mainlyBlueColor,
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          applyCoupon(context);

                                        },
                                        child: Text(
                                          'اضافة',
                                          style: TextStyle(
                                            color: ColorManager.orangeColor,
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorManager.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys.order_details.tr(),
                                          style: TextStyle(
                                            fontSize: FontSize.s18,
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        RecordItem(
                                            requestKey: 'تاريخ الوصول',
                                            value:DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(cubit.selectedDates.first))),
                                            // value: DateFormat.yMMMMd().format(DateTime.parse(widget.trip.arrivalDateTime))),
                                        RecordItem(
                                            requestKey: 'تاريخ المغادرة',
                                            value: DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(cubit.selectedDates.last))),
                                            // value: DateFormat.yMMMMd().format(DateTime.parse(widget.trip.leavingDateTime))),
                                        RecordItem(
                                            requestKey: 'وقت الوصول',
                                            value: '10 صباحا',),
                                        RecordItem(
                                            requestKey: 'وقت المغادرة',
                                            value: '10 مساءا',),
                                            // DateFormat('kk:mm a').format(DateTime.parse(widget.trip.leavingDateTime)),),
                                        RecordItem(
                                            requestKey: '${cubit.selectedDates.length} ليالي ${calculatePrice(cubit.selectedDates, widget.trip.price??Price()).average}xر.س',
                                            value: '${subtotalPrice} ر.س'),
                                        RecordItem(
                                            requestKey: 'ضريبة القيمة المضافة ',
                                            value: '${(subtotalPrice*0.15).toStringAsFixed(2)} ر.س'),
                                        if(_checked)
                                        RecordItem(
                                            requestKey: 'خصم المحفظة ',
                                            value: '${walletDiscount.toStringAsFixed(2)} ر.س'),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        const SizedBox(height: 15,),
                                        RecordItem(
                                            requestKey: 'الاجمالي',
                                            value: '${((subtotalPrice*0.15) +(subtotalPrice)).toStringAsFixed(2)} ر.س',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),


                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(
                              0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 3,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorManager.darkGreyColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   'مدينة الكشتة',
                                //   style: TextStyle(
                                //       color: ColorManager.blackColor),
                                // ),
                                // Text(
                                //   widget.trip.city?.name??'',
                                //   style: TextStyle(
                                //       color: ColorManager.blackColor),
                                // ),
                              ],
                            ),
                          ),
                          BlocListener<AppBloc, AppState>(
                            listener: (context, state) async{
                              print(state);
                              if(state is SuccessReserveTripState){

                                var alert =  AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor : Colors.green,
                                        child: FaIcon(FontAwesomeIcons.check,color: Colors.white,),
                                      ),
                                      SizedBox(height: 25),
                                      Text('تم الدفع بنجاح',style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        fontSize: 20,

                                      ),),
                                      SizedBox(height: 10),
                                      Text('نشكر لك اختيار كشتات',style: TextStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: 12,

                                      ),),
                                      SizedBox(height: 25),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text('موافق')),
                                    ],
                                  ),
                                );

                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                ).then((value){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashboardScreen(selectedIndex: 1,)));
                                });
                                // final snackBar = SnackBar(
                                //   content: Center(child: Text('تم الدفع',textAlign: TextAlign.center,)),
                                // );
                                // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                // context.push(ScreenName.dashboard);
                              }

                              if(state is FailureReserveTripState){
                                final snackBar = SnackBar(
                                  content: Center(child: Text(state.msg,textAlign: TextAlign.center,)),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: SizedBox(
                                width: size.width,
                                height: 45,
                                child: ElevatedButton(

                                  style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all<Color>(ColorManager.mainlyBlueColor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        )
                                    ),
                                    side: MaterialStateProperty.resolveWith<BorderSide>(
                                            (states) => BorderSide(color: ColorManager.mainlyBlueColor)),
                                  ),
                                  onPressed: () {
                                    final cubit = BlocProvider.of<AppBloc>(context);
                                    cubit.reserveTrip(total: subtotalPrice+subtotalPrice*0.15 , vat: subtotalPrice*0.15,subtotal: subtotalPrice,paymentMethods:  [3],walletAmount: walletDiscount);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(LocaleKeys.pay.tr(),style: TextStyle(color: Colors.white),),
                                        const SizedBox(width: 10,),
                                        SizedBox(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('${(subtotalPrice * 0.15 + subtotalPrice).toStringAsFixed(2)} ر.س',style: TextStyle(color: Colors.white),)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "15% ${LocaleKeys.vat.tr()}",
                          //   style: TextStyle(color: ColorManager.orangeColor),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateOrderPrice(){
    final cubit = BlocProvider.of<AppBloc>(context);
    CalculatedPrice totalPrices = calculatePrice(cubit.selectedDates, widget.trip.price??Price());
    double subtotal = totalPrices.total;
     walletDiscount = 0.0 ;
     if(_checked){
       if(double.parse((cubit.userProfile?.wallet??'0.0').toString()) > subtotal){
         walletDiscount = subtotal;
       }else{
         walletDiscount =  double.parse((cubit.userProfile?.wallet??'0.0').toString());
       }
     }
    subtotal = subtotal - walletDiscount;
    double totalAfterDiscount = subtotal - (subtotal *(discountPercentage/100));
    subtotalPrice = double.parse(totalAfterDiscount.toStringAsFixed(2));
    setState(() {});
  }

  applyCoupon(BuildContext context){

    final cubit = BlocProvider.of<AppBloc>(context);
    customBottomSheet(
        context,  'اضف كود خصم' ,Container(
      width: MediaQuery.of(context)
          .size
          .width,
      decoration: BoxDecoration(
        color:
        ColorManager.whiteDarkColor,
        borderRadius:
        const BorderRadius.only(
          topLeft:
          Radius.circular(50.0),
          topRight:
          Radius.circular(50.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              style: TextStyle(
                  fontWeight: FontWeightManager.bold,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontSize: FontSize.s14
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2),width: 1)
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5),
                    fontFamily: FontConstants.fontFamilyAR,fontSize: 12),
                hintText: "كشتات",
                fillColor: Colors.white70,

                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2),width: 1)
                ),

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2),width: 1)
                ),

              ),
              cursorColor: ColorManager.mainlyBlueColor,
            ),
          ),
          BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return KButton(

                onTap: (){
                if(controller.text.isEmpty){
                  return;
                }
                cubit.validateCoupon(code: controller.text, unitId: widget.trip.id!).then((value){

                  setState(() {
                    discountPercentage = value??0;
                  });
                  calculateOrderPrice();
                  Navigator.pop(context);
                });
              }, title: 'تطبيق',isLoading: state is ValidateCouponLoadingState,);
            },
          ),
          SizedBox(height: 20,),

        ],
      ),
    ));
  }
}