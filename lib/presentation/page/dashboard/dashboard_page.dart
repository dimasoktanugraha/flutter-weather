// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather/presentation/page/setting/setting_page.dart';

import '../../../common/colors.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';

class DashboardPage extends StatefulWidget {
  final int currentTab;
  const DashboardPage({
    super.key,
    required this.currentTab,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  late int _selectedIndex;
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const SettingPage()
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    _selectedIndex = widget.currentTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              color: AppColors.primary,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: AppColors.grey,
            ),
            activeIcon: Icon(
              Icons.search,
              color: AppColors.primary,
            ),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: AppColors.grey,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: AppColors.primary,
            ),
            label: 'SETTING',
          ),
          // BottomNavigationBarItem(
          //   icon: Assets.icons.home.svg(
          //     colorFilter: const ColorFilter.mode(
          //       AppColors.grey,
          //       BlendMode.srcIn,
          //     ),
          //   ),
          //   activeIcon: Assets.icons.home.svg(),
          //   label: 'HOME',
          // ),
          // BottomNavigationBarItem(
          //   icon: Assets.icons.order.svg(
          //     colorFilter: const ColorFilter.mode(
          //       AppColors.grey,
          //       BlendMode.srcIn,
          //     ),
          //   ),
          //   activeIcon: Assets.icons.order.svg(),
          //   label: 'SEARCH',
          // ),
        ],
      ),
    );
  }
}