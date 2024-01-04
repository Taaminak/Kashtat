import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/AppState.dart';
import '../Widgets/ItemScreenTitle.dart';
import '../Widgets/Loader.dart';

class ArrivalInstructionsScreen extends StatefulWidget {
  const ArrivalInstructionsScreen({Key? key}) : super(key: key);

  @override
  State<ArrivalInstructionsScreen> createState() =>
      _ArrivalInstructionsScreenState();
}

class _ArrivalInstructionsScreenState extends State<ArrivalInstructionsScreen> {


  TextEditingController instruction1Controller = TextEditingController();
  TextEditingController instruction2Controller = TextEditingController();
  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    setState(() {
      instruction1Controller.text = cubit.selectedUnit.instruction1??'';
      instruction2Controller.text = cubit.selectedUnit.instruction2??'';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text(
          'تعليمات الوصول',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(txt: 'تعليمات الوصول'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'لتسهيل عملية تسجيل دخول الضيوف بإمكانك إضافة تعليمات الوصول وستكون التعليمات ظاهرة للضيوف بعد تأكيد الحجز وبذلك لن يحتاج الضيف إلى سؤالك عند الوصول',
                  style: TextStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.darkerGreyColor),
                ),
                SizedBox(
                  height: 20,
                ),
                TitleWidget(
                    txt:
                        'عند وصول الضيف ما الطريقة التي ترغب ان يسجل في الدخول ؟'),
                SizedBox(
                  height: 10,
                ),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffDDDDDD), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          minLines: 10,
                          maxLines: 10,
                          controller: instruction1Controller,
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s14),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: FontSize.s14),
                            fillColor: Colors.white30,
                            hintText:
                                'مثال يتصل على رقم الجوال وابلغه بوصولك يذهب مباشرة إلى مكتب الاستقبال تسجل دخول ذاتي - اخرى', /*contentPadding: EdgeInsets.zero*/
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TitleWidget(txt: 'تعليمات اخرى'),
                SizedBox(
                  height: 10,
                ),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffDDDDDD), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          minLines: 10,
                          maxLines: 10,
                          controller: instruction2Controller,
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s14),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: FontSize.s14),
                              fillColor: Colors.white30,
                              hintText:
                                  'مثال : اذا لم تجد احد في الاستقبال اتصل على \n05000000000' /*contentPadding: EdgeInsets.zero*/),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<AppBloc, AppState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Container(
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () async {
                            final pics = await cubit.pickImage(ImagePickerType.singleImage);
                            cubit.updateNewUnitInstructionPhotos(pics.first);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //     color: const Color(0xffDDDDDD), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),

                                if (cubit.instructionImage != null)
                                  Image.file(
                                    File(cubit.instructionImage!.path),
                                    // You can access it with . operator and path property
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                if (cubit.instructionImage == null)
                                  Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.white,
                                      child: CachedNetworkImage(
                                        imageUrl: cubit.selectedUnit.instructionImage??'',
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Loader(),
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.camera_alt,
                                          size: 80,
                                          color: ColorManager.darkGreyColor,
                                        ),

                                      ),
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'اضف صورة',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                BlocConsumer<AppBloc, AppState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return KButton(
                      onTap: () {
                        cubit.updateNewUnitInstructions(inst1: instruction1Controller.text, inst2: instruction2Controller.text);
                        cubit.updateUnitArrivalInstructions();
                      },
                      title: 'اضافة',
                      width: size.width,
                      paddingV: 15,
                      isLoading: state is UpdateUnitLoadingState,
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
