import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kashtat/Core/models/ReservationModel.dart';
import 'package:kashtat/Features/Report%20Screen/SendReportScreen.dart';
import 'package:toggle_list/toggle_list.dart';
import '../../../Core/Extentions/extention.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../Core/constants/ImageManager.dart';
import '../../../translations/locale_keys.g.dart';
import '../../Map Screen/MapScreen.dart';
import '../../Popup Image Slider/PopupSliderImage.dart';
import '../../Request Details/Widgets/RequestDetailsWidget.dart';
import '../../Wallet Logs Screen/Widgets/WalletItemWidget.dart';
import '../../Widgets/Loader.dart';

class RequestItemWidget extends StatefulWidget {
  const RequestItemWidget(
      {Key? key, this.activeRequests = false, this.isNotification = false, required this.reservated})
      : super(key: key);
  final bool activeRequests;
  final bool isNotification;
  final ReservationModel reservated;

  @override
  State<RequestItemWidget> createState() => _RequestItemWidgetState();
}

class _RequestItemWidgetState extends State<RequestItemWidget> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorManager.whiteColor,
          boxShadow: [
            BoxShadow(
              color: widget.activeRequests
                  ? ColorManager.mainlyBlueColor.withOpacity(0.5)
                  : ColorManager.greyColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // if(activeRequests)
              // const StepperWidget(),
              // const SizedBox(height: 20),
              SizedBox(
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
                          imageUrl: widget.reservated.unit.mainPic??'',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Loader(),
                          errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.reservated.unit.name??'',
                              style: TextStyle(
                                fontSize: FontSize.s17,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.star,
                                      color: (i+1)>widget.reservated.unit.rate!.round()?Colors.grey:ColorManager.yellowColor,
                                      size: 15,
                                    ),
                                  ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    widget.reservated.unit.rate!.toString(),
                                    style: TextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 0),
                            Row(
                              children: [
                                Image.asset(ImageManager.marker,
                                    color: ColorManager.lightBlueColor,
                                    width: 12),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(showSelectLocation: false,lat: widget.reservated.unit.latitude??0.0,long: widget.reservated.unit.longitude??0.0,)));
                                  },
                                  child: Text(
                                    widget.reservated.unit.city?.name??'',
                                    style: TextStyle(
                                        color: ColorManager.lightBlueColor,
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeightManager.bold),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  'كود الوحدة (${widget.reservated.unit.id})',
                                  style: TextStyle(
                                      color: ColorManager.blackColor,
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.bold),
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
              const SizedBox(height: 20),
              ContainerDecorated(
                content: Row(
                  children: [
                    InternalAndExternalWidget(
                        title: "تفاصيل الدخول", img: ImageManager.indor,reserved: widget.reservated),
                    InternalAndExternalWidget(
                        title: "تفاصيل الخروج", img: ImageManager.outdor,reserved: widget.reservated,isArrival: false),
                  ],
                ),
                addPadding: false,
              ),
              // Divider(),
              // const SizedBox(height: 20),
              ToggleList(
                shrinkWrap: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                trailing: true? SizedBox(): Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 15,
                    color: ColorManager.orangeColor,
                  ),
                ),
                trailingExpanded:true? SizedBox(): Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: 15,
                    color: ColorManager.orangeColor,
                  ),
                ),

                children: [
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),
                    onExpansionChanged: (int index, bool expanded){
                      if(expanded){
                        selectedIndex = index;
                      }else{
                        selectedIndex = -1;
                      }
                      setState(() {
                      });
                    },
                    leading: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(showSelectLocation: false,lat: widget.reservated.unit.latitude??0.0,long: widget.reservated.unit.longitude??0.0,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImageManager.loc,color: ColorManager.orangeColor,width: 18,),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(showSelectLocation: false,lat: widget.reservated.unit.latitude??0.0,long: widget.reservated.unit.longitude??0.0,)));
                            },
                            child: const Text(
                              'موقع الكشتة (اللوكيشن)',
                              style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              selectedIndex ==0? FontAwesomeIcons.chevronDown : FontAwesomeIcons.chevronLeft,
                              size: 15,
                              color: ColorManager.orangeColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    content:  Padding(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),

                          child: SizedBox(child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(showSelectLocation: false,lat: widget.reservated.unit.latitude??0.0,long: widget.reservated.unit.longitude??0.0,)));
                              },
                              child: Image.asset(ImageManager.map,width: 180,height: 100,fit: BoxFit.fill,)))),
                    ),
                  ),
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),
                    onExpansionChanged: (int index, bool expanded){
                      if(expanded){
                        selectedIndex = index;
                      }else{
                        selectedIndex = -1;
                      }
                      setState(() {
                      });
                    },
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImageManager.finger,color: ColorManager.orangeColor,width: 18,),
                    ),
                    title: Row(
                      children: [
                        const Text(
                          'تعليمات الوصول',
                          style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            selectedIndex == 1? FontAwesomeIcons.chevronDown:FontAwesomeIcons.chevronLeft,
                            size: 15,
                            color: ColorManager.orangeColor,
                          ),
                        )
                      ],
                    ),
                    content:  SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.reservated.unit.instruction1??'',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'تعليمات اخرى',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.reservated.unit.instruction2??'',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'صورة باب الوحدة',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                ),
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                                  child: InkWell(
                                    onTap: (){

                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                            transitionsBuilder: (context, animation, __, child) {
                                              return Align(
                                                child: SizeTransition(
                                                  sizeFactor: animation,
                                                  child: child,
                                                ),
                                              );
                                            },
                                            pageBuilder: (context, _, __) => ShowImages(index: 0,imagesUrl: [widget.reservated.unit.instructionImage??'']),
                                            opaque: false,
                                            barrierColor: Colors.black.withOpacity(0.3)
                                        ),
                                      );

                                    },
                                    child: SizedBox(
                                      width: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.reservated.unit.instructionImage??'',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Loader(),
                                          errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),onExpansionChanged: (int index, bool expanded){
                    if(expanded){
                      selectedIndex = index;
                    }else{
                      selectedIndex = -1;
                    }
                    setState(() {
                    });
                  },
                    leading: InkWell(
                      onTap: (){
                        try{
                          String url = "tel://${widget.reservated.unit.provider!.phone!.substring(1)}";
                          launchURL(url);
                        }catch(e){

                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(ImageManager.phone,color: ColorManager.orangeColor,width: 18,),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              try{
                                String url = "tel://${widget.reservated.unit.provider!.phone!.substring(1)}";
                                launchURL(url);
                              }catch(e){

                              }
                            },
                            child: const Text(
                              'تواصل مع المضيف',
                              style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              selectedIndex == 2? FontAwesomeIcons.chevronDown:FontAwesomeIcons.chevronLeft,
                              size: 15,
                              color: ColorManager.orangeColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    content: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(''),
                    ),
                  ),
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),onExpansionChanged: (int index, bool expanded){
                    if(expanded){
                      selectedIndex = index;
                    }else{
                      selectedIndex = -1;
                    }
                    setState(() {
                    });
                  },
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImageManager.loc,color: ColorManager.orangeColor,width: 18,),
                    ),
                    title: Row(
                      children: [
                        const Text(
                          'بيانات الحجز',
                          style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            selectedIndex == 3? FontAwesomeIcons.chevronDown:FontAwesomeIcons.chevronLeft,
                            size: 15,
                            color: ColorManager.orangeColor,
                          ),
                        )
                      ],
                    ),
                    content: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'رقم الحجز',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.reservated.id.toString(),
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'اسم الوحدة',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.reservated.unit.name??'',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'شروط الحجز',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.reservated.unit.reservationRoles??'',style: TextStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: FontSize.s12,
                                  height: 1.5),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'بيانات المضيف',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.reservated.unit.provider?.name??'',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ملخص الحجز',
                              style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.order_details.tr(),
                                  style: TextStyle(
                                    fontSize: FontSize.s17,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                RecordItem(
                                    requestKey: 'تاريخ الوصول',
                                    value: widget.reservated.arrivalDateTime),
                                // value: DateFormat.yMMMMd().format(DateTime.parse(widget.trip.arrivalDateTime))),
                                RecordItem(
                                    requestKey: 'تاريخ المغادرة',
                                    value: widget.reservated.leavingDateTime),
                                // value: DateFormat.yMMMMd().format(DateTime.parse(widget.trip.leavingDateTime))),
                                RecordItem(
                                  requestKey: 'وقت الوصول',
                                  value:
                                  '10 صباحا',),
                                RecordItem(
                                  requestKey: 'وقت المغادرة',
                                  value:
                                  '10 مساءا',),
                                // DateFormat('kk:mm a').format(DateTime.parse(widget.trip.leavingDateTime)),),
                                RecordItem(
                                    requestKey: '${widget.reservated.unit.price?.others == null? '':(double.parse(widget.reservated.subtotal)/int.parse(widget.reservated.unit.price?.others??'1')).round()} ليالي ${widget.reservated.subtotal}xر.س',
                                    value: '${widget.reservated.subtotal} ر.س'),
                                RecordItem(
                                    requestKey: 'ضريبة القيمة المضافة 15%',
                                    value: '${widget.reservated.vat} ر.س'),
                                // Divider(
                                //   thickness: 2,
                                //   height: 40,
                                // ),
                                RecordItem(
                                  requestKey: 'الاجمالي',
                                  value: '${widget.reservated.total} ر.س',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),onExpansionChanged: (int index, bool expanded){
                    if(expanded){
                      selectedIndex = index;
                    }else{
                      selectedIndex = -1;
                    }
                    setState(() {
                    });
                  },
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(ImageManager.question,color: ColorManager.orangeColor,width: 18,),
                    ),
                    title: Row(
                      children: [
                        const Text(
                          'سياسة الإلغاء و الاسترجاع',
                          style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FaIcon(
                            selectedIndex == 4? FontAwesomeIcons.chevronDown:FontAwesomeIcons.chevronLeft,
                            size: 15,
                            color: ColorManager.orangeColor,
                          ),
                        )
                      ],
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(widget.reservated.unit.cancellationPolicy??'',
                        style: TextStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s12,
                        ),),
                    ),
                  ),
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),onExpansionChanged: (int index, bool expanded){
                    if(expanded){
                      selectedIndex = index;
                    }else{
                      selectedIndex = -1;
                    }
                    setState(() {
                    });
                  },
                    leading: InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImageManager.trueCircle,color: ColorManager.orangeColor,width: 18,),
                      ),
                    ),
                    title:  InkWell(
                    onTap: (){},
                      child: Text(
                        'رقم الحجز   ${widget.reservated.id}',
                        style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                      ),
                    ),
                    content: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(''),
                    ),
                  ),
                  ToggleListItem(
                    itemDecoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),onExpansionChanged: (int index, bool expanded){
                    if(expanded){
                      selectedIndex = index;
                    }else{
                      selectedIndex = -1;
                    }
                    setState(() {
                    });
                  },
                    leading: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SendReportScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(ImageManager.info,color: ColorManager.orangeColor,width: 18,),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SendReportScreen()));
                            },
                            child: const Text(
                              'رفع بلاغ او شكوى',
                              style: TextStyle(fontWeight: FontWeightManager.bold,fontSize: 16),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SendReportScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(
                              selectedIndex == 3? FontAwesomeIcons.chevronDown:FontAwesomeIcons.chevronLeft,
                              size: 15,
                              color: ColorManager.orangeColor,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                    content: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(''),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InternalAndExternalWidget extends StatelessWidget {
  const InternalAndExternalWidget({
    super.key,
    required this.title,
    required this.img,
    this.reserved,
    this.isArrival = true
  });

  final bool isArrival;
  final String img;
  final String title;
  final ReservationModel? reserved;

  // final String time;
  // final String date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              img,
              width: 30,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            // DateFormat('y-MM-dd').format
            const SizedBox(height: 10),
            Text(isArrival? "10 صباحا":"10 مساءا",style: TextStyle(
                color: ColorManager.darkerGreyColor,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(isArrival?DateFormat("EE, MMM d, yyyy").format(DateTime.parse(DateTime(int.parse(reserved!.arrivalDateTime.split('-')[2]),int.parse(reserved!.arrivalDateTime.split('-')[1]),int.parse(reserved!.arrivalDateTime.split('-')[0]),).toString())):DateFormat("EE, MMM d, yyyy").format(DateTime.parse(DateTime(int.parse(reserved!.leavingDateTime.split('-')[2]),int.parse(reserved!.leavingDateTime.split('-')[1]),int.parse(reserved!.leavingDateTime.split('-')[0]),).toString())),style: TextStyle(
                color: ColorManager.darkerGreyColor,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
