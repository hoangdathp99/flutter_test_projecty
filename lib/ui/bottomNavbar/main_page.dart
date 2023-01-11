import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/action.dart';
import 'package:flutter_application_1/navigation/app_router.dart';
import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/ui/bottomNavbar/bottom_nav_bar.dart';
import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';
import 'package:flutter_application_1/ui/login/login_page.dart';
import 'package:flutter_application_1/ui/pageThird/pageThird.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PersistentTabController _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(title: "Home"),
    SecondScreen(),
    PageThird(title: "Third")
  ];
  final List<BottomNavItem> _listBottomNavItems = const [
    BottomNavItem(title: "homeLabel", icon: Icons.home),
    BottomNavItem(title: "activityLabel", icon: Icons.receipt),
    BottomNavItem(title: "walletLabel", icon: Icons.credit_card),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Home",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              navigatorKey: navigatorKey,
              initialRoute: RoutePaths.start,
              onGenerateRoute: RouterApp.generateRoute,
            )),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.receipt),
            title: "Home",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              navigatorKey: navigatorKey,
              initialRoute: RoutePaths.start,
              onGenerateRoute: RouterApp.generateRoute,
            )),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.credit_card),
            title: "Home",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
            routeAndNavigatorSettings: RouteAndNavigatorSettings(
              navigatorKey: navigatorKey,
              initialRoute: RoutePaths.start,
              onGenerateRoute: RouterApp.generateRoute,
            )),
      ];
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: IndexedStack(index: _selectedIndex, children: _pages),
      // ),
      // persistentFooterButtons: [
      //   Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: List.generate(
      //       _listBottomNavItems.length,
      //       (index) {
      //         return BottomNavItem(
      //             title: _listBottomNavItems[index].title,
      //             icon: _listBottomNavItems[index].icon,
      //             isSelected: _selectedIndex == index,
      //             onTap: () {
      //               _onItemTapped(index);
      //             });
      //       },
      //     ),
      //   ),
      // ],
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pages,
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        bottomScreenMargin: 0,
        backgroundColor: Colors.black,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle: NavBarStyle.style19,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
