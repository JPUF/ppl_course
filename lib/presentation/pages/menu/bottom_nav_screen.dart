import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ppl_course/presentation/pages/home/home_page.dart';
import 'package:ppl_course/presentation/pages/plan_session/plan_session_page.dart';
import 'package:ppl_course/presentation/pages/stats/stats_page.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

enum BottomNavDestination { home, plan, progression }

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late final PersistentTabController _controller;
  bool _hideNavBar = false;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  void navigateTo(BottomNavDestination destination) {
    _controller.jumpToTab(destination.index);
  }

  void setNavBarVisibility(bool isVisible) {
    setState(() => _hideNavBar = !isVisible);
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(toBottomNavDestination: (d) => navigateTo(d)),
      PlanSessionPage(
          toBottomNavDestination: (d) => navigateTo(d),
          setNavBarVisibility: (v) => setNavBarVisibility(v)),
      const StatsPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.menu),
          title: "All Sessions",
          activeColorPrimary: AppColor.dark,
          inactiveColorPrimary: AppColor.grey50,
          textStyle: AppTextStyles.navBarItemText),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.edit),
          title: "Plan Session",
          activeColorPrimary: AppColor.dark,
          inactiveColorPrimary: AppColor.grey50,
          textStyle: AppTextStyles.navBarItemText),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.fitness_center),
          title: "Progression",
          activeColorPrimary: AppColor.dark,
          inactiveColorPrimary: AppColor.grey50,
          textStyle: AppTextStyles.navBarItemText),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarItems(),
        hideNavigationBar: _hideNavBar,
        confineInSafeArea: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popActionScreens: PopActionScreensType.all,
        screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true, curve: Curves.ease),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
