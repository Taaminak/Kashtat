import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/constants/ColorManager.dart';
import '../../translations/locale_keys.g.dart';
import 'dart:ui' as ui;

import '../Wallet Logs Screen/Widgets/WalletItemWidget.dart';
import '../Widgets/Loader.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key,required this.name, required this.phone, required this.avatar, required this.userType}) : super(key: key);
  final String name;
  final String avatar;
  final String phone;
  final String userType;
  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool edit = false;
  XFile? image;
  @override
  void initState() {
    print(widget.avatar);
    avatar = widget.avatar;
    phoneController.text = widget.phone.substring(4);
    nameController.text = widget.name;
    super.initState();
  }

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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: MediaQuery.of(context).viewPadding.top + 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 20),
                      Image.asset(
                        ImageManager.logoWithTitleHColored,
                        width: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'الملف الشخصي',
                        style: TextStyle(
                          fontSize: FontSize.s34,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ContainerDecorated(
                          content: Column(
                            children: [
                              if(widget.userType == "provider"&&cubit.userType == UserType.isProvider)

                              SizedBox(height: 10),
                              if(widget.userType == "provider"&&cubit.userType == UserType.isProvider)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: Colors.grey.withOpacity(0.8))
                                        ),
                                        child: image != null?
                                    Image.file(
                                File(image!.path), // You can access it with . operator and path property
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ): CachedNetworkImage(
                                          imageUrl: avatar??'',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Loader(),
                                          errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                                        ))),
                              ),
                              // SizedBox(height: 17),
                            if(edit && widget.userType == "provider"&&cubit.userType == UserType.isProvider)
                              TextButton(onPressed: ()async{

                                List<XFile> pickedImage = await cubit.pickImage(ImagePickerType.singleImage);
                                if(pickedImage.isNotEmpty){
                                  setState(() {
                                    image = pickedImage[0];
                                  });
                                }

                              }, child: const Text('تعديل الصورة الرمزية',
                                style: TextStyle(
                                    fontWeight: FontWeightManager.bold,
                                    color: Color(0xff004CFF),
                                fontSize: 12),)),
                              SizedBox(height: 17),
                              Row(
                                children: [
                                  SizedBox(width: 100,
                                    child: Text("الاسم",
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          color: Colors.black),),),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: TextField(
                                          controller: nameController,
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              fontFamily: GoogleFonts.lato().fontFamily,
                                              fontSize: FontSize.s14
                                          ),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: FontSize.s14),
                                              fillColor: Colors.white70,
                                              hintText: LocaleKeys.name.tr().capitalize(),
                                              contentPadding: EdgeInsets.zero),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 17),
                              Row(
                                children: [
                                  SizedBox(width: 100,
                                    child: Text("رقم الموبايل",
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                      color: Colors.black),),),
                                  Expanded(
                                    child: Directionality(
                                      textDirection: ui.TextDirection.ltr,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                ImageManager.ksaLogo,
                                                width: 20,
                                              ),
                                              const Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0, left: 5, right: 5),
                                                child: Text(
                                                  '+966',
                                                  style: TextStyle(
                                                      fontWeight: FontWeightManager.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextField(
                                                  keyboardType: TextInputType.number,
                                                  controller: phoneController,
                                                  style: TextStyle(
                                                      fontWeight: FontWeightManager.bold,
                                                      fontFamily: GoogleFonts.lato().fontFamily,
                                                      fontSize: FontSize.s14
                                                  ),
                                                  decoration: InputDecoration(
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(8.0),
                                                        borderSide: BorderSide.none,
                                                      ),
                                                      filled: true,
                                                      hintStyle:
                                                      TextStyle(color: Colors.grey[800]),
                                                      fillColor: Colors.white70,
                                                      contentPadding: EdgeInsets.zero),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              if(!edit)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    KButton(onTap: (){
                                      setState(() {
                                        edit = !edit;
                                      });
                                    }, title: "تعديل",),
                                    KButton(onTap: (){}, title: "حذف"),
                                  ],
                                ),
                              if(edit)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    KButton(onTap: (){
                                      cubit.updateProfile(phone: "+966${phoneController.text}", name: nameController.text, avatar: image).then((value) => getData());
                                    }, title: "حفظ",),
                                    KButton(onTap: (){
                                      setState(() {
                                        edit = !edit;
                                        image = null;
                                      });
                                    }, title: "إلغاء",clr: ColorManager.whiteColor,txtClr: ColorManager.mainlyBlueColor,),
                                  ],
                                )
                            ],
                          )
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String avatar = '';
  Future<void> getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatar = prefs.getString('avatar') ?? '' ;
      edit = !edit;
    });
  }
}
