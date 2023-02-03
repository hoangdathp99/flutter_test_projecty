import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/app_state_model.dart';
import 'package:flutter_application_1/model/product_repository.dart';
// import 'package:flutter_application_1/navigation/action.dart';
// import 'package:flutter_application_1/navigation/app_router.dart';
import 'package:flutter_application_1/navigation/home_navigator.dart';
// import 'package:flutter_application_1/navigation/routePaths.dart';
import 'package:flutter_application_1/navigation/second_screen_navigator.dart';
import 'package:flutter_application_1/navigation/third_navigator.dart';
import 'package:flutter_application_1/ui/bottomNavbar/bottom_nav_bar.dart';
// import 'package:flutter_application_1/ui/home_page.dart/home_screen.dart';
// import 'package:flutter_application_1/ui/login/login_page.dart';
// import 'package:flutter_application_1/ui/pageThird/pageThird.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Product> allProduct =
      Provider.of<AppStateModel>(context, listen: true).availableProducts;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // controller.jumpToPage(index);
  }

  int _selectedIndex = 0;
  // ignore: prefer_typing_uninitialized_variables
  var position = 0.0;
  Offset offset = Offset.zero;
  void _onHorizontalDragStart(DragStartDetails details) {
    position = 0;
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.primaryDelta != null) {
      setState(() {
        position = position - details.primaryDelta!.toDouble();
      });
      setState(() {
        offset = Offset(details.primaryDelta!, 0);
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details, double size) {
    if (position < -size / 2) {
      position = 0;
      if (_selectedIndex > 0) {
        _onItemTapped(_selectedIndex - 1);
      } else {
        _onItemTapped(_selectedIndex);
      }
      return;
    } else if (position > size / 2) {
      position = 0;
      if (_selectedIndex < 2) {
        _onItemTapped(_selectedIndex + 1);
      } else {
        _onItemTapped(_selectedIndex);
      }
    } else {
      setState(() {
        position = 0;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppStateModel>(context, listen: false).loadProducts();
    });
    super.initState();
    // controller =
    if (kDebugMode) {
      print(widget.title);
    }
    // _selectedIndex = controller.initialPage;
    // _controller = PersistentTabController();
  }

  static List<Widget> _pages(double position, double size) => <Widget>[
        AnimatedOpacity(
            opacity: position.abs() <= size / 2
                ? ((position).abs() / (size / 2) - 1).abs() % 2
                : 0,
            duration: const Duration(milliseconds: 300),
            child: const HomeNavigator()),
        AnimatedOpacity(
            opacity: position.abs() <= (size / 2)
                ? ((position).abs() / (size / 2) - 1).abs() % 2
                : 0,
            duration: const Duration(milliseconds: 300),
            child: const SecondNavigator()),
        AnimatedOpacity(
            opacity: position.abs() <= (size / 2)
                ? ((position).abs() / (size / 2) - 1).abs() % 2
                : 0,
            duration: const Duration(milliseconds: 300),
            child: const ThirdNavigator()),
      ];
  final List<BottomNavItem> _listBottomNavItems = const [
    BottomNavItem(title: "homeLabel", icon: Icons.home),
    BottomNavItem(title: "activityLabel", icon: Icons.receipt),
    BottomNavItem(title: "walletLabel", icon: Icons.credit_card),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragEnd: ((details) =>
            _onHorizontalDragEnd(details, MediaQuery.of(context).size.width)),
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          transform: Matrix4.translationValues(-position, 0, 0),
          child: Consumer<AppStateModel>(builder: (context, value, child) {
            return IndexedStack(
              index: _selectedIndex,
              children: _pages(position, MediaQuery.of(context).size.width),
            );
          }),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            _listBottomNavItems.length,
            (index) {
              return BottomNavItem(
                  title: _listBottomNavItems[index].title,
                  icon: _listBottomNavItems[index].icon,
                  isSelected: _selectedIndex == index,
                  onTap: () {
                    _onItemTapped(index);
                  });
            },
          ),
        ),
      ],
    );
  }
}
