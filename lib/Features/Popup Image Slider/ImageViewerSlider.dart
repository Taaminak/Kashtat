import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../Core/constants/ColorManager.dart';
import '../Widgets/Loader.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key,required this.index, required this.urls}) : super(key: key);
  final int index;
  final List<String> urls;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController controller1 = CarouselController();
  CarouselController controller2 = CarouselController();

  int currentPage =0;
  PageController? controller ;

  @override
  void initState() {
    controller = PageController(initialPage: widget.index);
    setState(() {
      currentPage = widget.index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(

        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                      itemCount: widget.urls.length,
                      onPageChanged: (pageIndex){
                      setState(() {
                        currentPage = pageIndex;
                      });
                      },
                      itemBuilder: (context,index){
                    return InteractiveViewer(
                      maxScale: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: CachedNetworkImage(
                          imageUrl: widget.urls[index],
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Loader(),
                          errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                        ),
                      ),
                    );
                  }),
                  Positioned(
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FaIcon(FontAwesomeIcons.times,color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: (){
                        controller!.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(FontAwesomeIcons.chevronRight,color: Colors.white,size: 15,),
                      )),
                  SizedBox(width: 15,),
                  Text("${widget.urls.length}/${currentPage + 1}",style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(width: 15,),
                  InkWell(
                      onTap: (){
                        controller!.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(FontAwesomeIcons.chevronLeft,color: Colors.white,size: 15,),
                      )),
                  // FaIcon(FontAwesomeIcons.chevronLeft,color: Colors.white,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
