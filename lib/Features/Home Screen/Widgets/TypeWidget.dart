import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Widgets/Loader.dart';

class HomeTypeWidgetGrid extends StatelessWidget {
  const HomeTypeWidgetGrid({Key? key, required this.onTap, required this.title, required this.img, required this.count, this.color, this.width, this.bgIconColor}) : super(key: key);
  final Function() onTap;
  final String title;
  final String img;
  final String count;
  final Color? color;
  final double? width;
  final Color? bgIconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 90,
        decoration: BoxDecoration(
          color: color ?? ColorManager.mainlyBlueColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(count,style: TextStyle(
                      color: ColorManager.white,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s22
                  ),
                  ),
                  const Spacer(),
                  Container(
                      height: 30,
                      width: 30,
                      child:
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: CachedNetworkImage(
                          imageUrl: img,
                          color: Colors.white,
                          placeholder: (context, url) => Loader(),
                          errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.white,),
                        ),
                      ),),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,style: TextStyle(
                        color: ColorManager.whiteColor,
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSize.s14
                    ),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTypeWidget extends StatelessWidget {
  const HomeTypeWidget({Key? key, required this.onTap, required this.title, required this.img, required this.count, this.color, this.width}) : super(key: key);
  final Function() onTap;
  final String title;
  final String img;
  final String count;
  final Color? color;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        decoration: BoxDecoration(
          color: color ?? ColorManager.mainlyBlueColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center ,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(count,style: TextStyle(
                  color: ColorManager.white,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s22
              ),),
              SizedBox(width: 30,),
              Text(
                title,style: TextStyle(
                  color: ColorManager.whiteColor,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s20
              ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CachedNetworkImage(
                  imageUrl: img,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 35,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Loader(),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.white,),
                ),
              ),
              // Image.asset(img,width: 35,),
            ],
          ),
        ),
      ),
    );
  }
}
