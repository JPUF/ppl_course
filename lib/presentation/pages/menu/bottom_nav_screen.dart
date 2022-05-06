import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ppl_course/presentation/pages/home/home_page.dart';
import 'package:ppl_course/presentation/pages/plan_session/plan_session_page.dart';
import 'package:ppl_course/presentation/pages/stats/stats_page.dart';
import 'package:ppl_course/res/color/colors.dart';
import 'package:ppl_course/res/styles/app_text_styles.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const PlanSessionPage(),
      const HomePage(),
      const StatsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.edit),
          title: "Plan Session",
          activeColorPrimary: AppColor.dark,
          inactiveColorPrimary: AppColor.grey50,
          textStyle: AppTextStyles.navBarItemText),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "All Sessions",
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
        confineInSafeArea: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
