import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Features/Popup%20Image%20Slider/ImageViewerSlider.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../Widgets/Loader.dart';

class ShowImages extends StatefulWidget {
  const ShowImages({Key? key, required this.index, required this.imagesUrl}) : super(key: key);
  final int index;
  final List<String> imagesUrl;

  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  int index = 0;
  List<ImageProvider> _imageProviders = [];
  @override
  void initState() {
    setState(() {
      index = widget.index;
      _imageProviders = widget.imagesUrl.map((e) => Image.network(e).image).toList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,leading: SizedBox(),
        actions: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: GridView.custom(
          semanticChildCount: 1,
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            pattern: [
              WovenGridTile(1),
              // WovenGridTile(
              //   5 / 7,
              //   crossAxisRatio: 0.9,
              //   alignment: AlignmentDirectional.centerEnd,
              // ),
            ],
          ),
          padding: EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: widget.imagesUrl.length,
                (context, itemIndex) => InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageSlider(index: itemIndex,urls: widget.imagesUrl,)));
                    // showImageViewer(
                    //   context,
                    //   CachedNetworkImageProvider(widget.imagesUrl[itemIndex]),
                    //   swipeDismissible: true,
                    // );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.imagesUrl[itemIndex],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Loader(),
                      errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}


class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;


  CustomImageProvider({required this.imageUrls, this.initialIndex = 0})
      : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    return NetworkImage(imageUrls[index]);
  }

  @override
  int get imageCount => imageUrls.length;
}
