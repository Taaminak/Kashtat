import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key,}) : super(key: key);
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String text = '';

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تواصل معنا',
                              style: TextStyle(
                                fontSize: FontSize.s34,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorManager.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0, 0), // changes position of shadow
                                  ),

                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child:Column(
                                  children: [
                                    TextFormField(
                                      controller: controller,
                                      minLines: 15,
                                      maxLines: 25,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      cursorColor: ColorManager.mainlyBlueColor,
                                      onChanged: (String text){
                                        setState(() {
                                          this.text = text;
                                        });
                                      },
                                    ),
                                    KButton(onTap: ()async{
                                      if(controller.text.isEmpty)
                                        return;
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final cubit = BlocProvider.of<AppBloc>(context);
                                      await cubit.createNewComplain(message: controller.text);
                                      Fluttertoast.showToast(
                                          msg: "Message Sent Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      setState(() {
                                        isLoading = false;
                                        controller.text = '';
                                      });
                                      // loading();
                                    }, title: 'ارسال',width: 200,paddingV: 15,isLoading: isLoading,clr: text.isEmpty?Colors.grey:Color(0xff482383),)
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool isLoading = false;
  Future<void> loading()async{setState(() {
    isLoading = true;
  });
    Future.delayed(Duration(seconds: 1),() {
      Fluttertoast.showToast(
          msg: "Message Sent Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      setState(() {
        isLoading = false;
        controller.text = '';
      });
    },);
  }
}
