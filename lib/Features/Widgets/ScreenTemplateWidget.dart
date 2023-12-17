import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../Wallet Logs Screen/Widgets/WalletItemWidget.dart';

class ScreenTemplateWidget extends StatelessWidget {
  const ScreenTemplateWidget({Key? key,required this.title, required this.content, this.button}) : super(key: key);
  final String title;
  final Widget content;
  final Widget? button;

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
                    Expanded(child:  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: FontSize.s34,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ContainerDecorated(
                            content: content
                        ),
                        if(button !=null)
                          const SizedBox(height: 50,),
                        button != null ? Center(child: button!) :  const SizedBox(),
                        const SizedBox(height: 20,)
                      ],),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
