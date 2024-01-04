import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Features/Widgets/DropDownMenuWidget.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../Widgets/ItemScreenTitle.dart';
import '../Widgets/kButton.dart';

class BankAccountSettings extends StatefulWidget {
  const BankAccountSettings({Key? key}) : super(key: key);

  @override
  State<BankAccountSettings> createState() => _BankAccountSettingsState();
}

class _BankAccountSettingsState extends State<BankAccountSettings> {
  String dropdownValue = '';
  int bankId = -1;
  TextEditingController nameHolderController = TextEditingController();
  TextEditingController ipanController = TextEditingController();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData()async{
    final cubit = BlocProvider.of<AppBloc>(context);
    await cubit.getAllBanks();
    if(cubit.allBanks.isNotEmpty){
      setState(() {
        dropdownValue = cubit.allBanks.first.name??'';
        bankId = cubit.allBanks.first.id??-1;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text('اعدادات الحساب البنكي',style: TextStyle(fontWeight: FontWeight.normal),),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: (){
              context.pop();
            },
            child: const Padding(
              padding:  EdgeInsets.all(16.0),
              child:  FaIcon(FontAwesomeIcons.chevronLeft,size:20,color: Colors.white,),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(txt: 'اختر البنك'),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          isExpanded: true,
                          iconDisabledColor: ColorManager.orangeColor,
                          iconEnabledColor: ColorManager.orangeColor,
                          items: cubit.allBanks.map((e) => e.name??'').toList().map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            print('=========================');
                            print(newValue);
                            print('=========================');
                            setState(() {
                              dropdownValue = (cubit.allBanks.firstWhere((element) => element.name == newValue)).name!;
                              bankId = cubit.allBanks.first.id!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TitleWidget(txt: 'اسم صاحب الحساب'),
                SizedBox(height: 10,),
                TextFieldWidget(hint: 'اكتب اسم صاحب الحساب',controller: nameHolderController),
                SizedBox(height: 20,),
                TitleWidget(txt: 'رقم الايبان'),
                SizedBox(height: 10,),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: TextFieldWidget(hint: 'SA',hasPrefix: true,controller: ipanController),
                ),
                SizedBox(height: 40,),
                BlocConsumer<AppBloc, AppState>(
                  listener: (context, state) {
                    if(state is CreateNewBankAccountLoadingState){
                      Fluttertoast.showToast(
                          msg: "تم اضافة الحساب بنجاح",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    if(state is CreateNewBankAccountFailureState){
                      Fluttertoast.showToast(
                          msg: "لم يتم اضافة الحساب بنجاح",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                  builder: (context, state) {
                    return KButton(onTap: (){
                      cubit.createNewBankAccount(name: nameHolderController.text, iban: ipanController.text, bankId: bankId);
                    }, title: 'حفظ',width: size.width,paddingV: 15,isLoading: state is CreateNewBankAccountLoadingState,);
                  },
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key, required this.hint, required this.controller, this.hasPrefix = false}) : super(key: key);
  final String hint;
  final bool hasPrefix;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffDDDDDD), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: controller,
              style: TextStyle(
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s14
              ),

              decoration: InputDecoration(

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,

                  hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: FontSize.s12),
                  fillColor: Colors.white30,
                  hintText: hasPrefix?null:hint,
                  icon:hasPrefix? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('SA',style: TextStyle(fontWeight: FontWeightManager.bold),),
                  ):null,
                  contentPadding: EdgeInsets.zero),
            ),
          ),
        ),
      );
  }
}

