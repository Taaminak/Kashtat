import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Home%20Screen/HomeScreen.dart';
import 'package:kashtat/Features/More%20Screen/MoreScreen.dart';
import 'package:kashtat/Features/My%20Requests/MyRequestsScreen.dart';
import 'package:kashtat/Features/Notification%20Screen/NotificationScreen.dart';
import 'package:kashtat/Features/Service%20Provider/Calender/SPCalenderScreen.dart';
import 'package:kashtat/Features/Service%20Provider/Home/SPHomeScreen.dart';
import 'package:kashtat/Features/Service%20Provider/SP%20Reservations/SPREservationsScreen.dart';
import 'package:kashtat/Features/Service%20Provider/SP%20Units/SPUnitsScreen.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key , this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _normalUserScreens = <Widget>[
    HomeScreen(title: ''),
    // NotificationsScreen(fromDashboard: true),
    MyRequestsScreen(fromDashboard: true),
    MoreScreen(fromDashboard: true),
  ];

  static const List<Widget> _providerUserScreens = <Widget>[
    SPHome(),
    SPCalenderScreen(),
    SPReservations(),
    SPUnitsScreen(),
    MoreScreen(fromDashboard: true),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
  listener: (context, state) {
    if(state is UserChangedState){
      final cubit = BlocProvider.of<AppBloc>(context);
      setState(() {
        _selectedIndex = cubit.userType == UserType.isNormal? _normalUserScreens.length-1:_providerUserScreens.length-1;
      });
    }
  },
  builder: (context, state) {
    final cubit = BlocProvider.of<AppBloc>(context);
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: Center(
          child:cubit.userType == UserType.isNormal?  _normalUserScreens.elementAt(_selectedIndex):_providerUserScreens.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items:   cubit.userType == UserType.isNormal? <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(ImageManager.logo,width: 15,color: _selectedIndex ==0?ColorManager.orangeColor:ColorManager.darkerGreyColor,),
              label: LocaleKeys.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark_outline),
              label: LocaleKeys.orders.tr(),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(ImageManager.user,width: 18,color: _selectedIndex ==2?ColorManager.orangeColor:ColorManager.darkerGreyColor,),
              label: LocaleKeys.account.tr(),
            ),
          ]:<BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(ImageManager.logo,width: 15,color: _selectedIndex ==0?ColorManager.orangeColor:ColorManager.darkerGreyColor,),
              label: LocaleKeys.home.tr(),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'التقويم',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              label: 'الحجوزات',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'الوحدات',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(ImageManager.user,width: 18,color: _selectedIndex ==4?ColorManager.orangeColor:ColorManager.darkerGreyColor,),
              label: LocaleKeys.account.tr(),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: ColorManager.orangeColor,
          unselectedItemColor: ColorManager.darkerGreyColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  },
);
  }
}
