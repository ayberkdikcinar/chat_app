import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/extension/context_extension.dart';
import '../home/view/home_view.dart';
import '../not_found_view.dart';
import 'default_tab_viewmodel.dart';

class DefaulTabView extends StatelessWidget {
  const DefaulTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<DefaultTabViewModel>(context);
    return Scaffold(
        body: PageView(
          controller: vm.pageController,
          onPageChanged: (value) {
            vm.setPageIndex(value);
          },
          children: [
            HomeView(),
            NotFoundView(),
            NotFoundView(),
            NotFoundView(),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(context, vm));
  }

  Padding bottomNavigationBar(BuildContext context, DefaultTabViewModel vm) {
    return Padding(
      padding: context.paddingNormal,
      child: buildContainer(context, vm),
    );
  }

  Container buildContainer(BuildContext context, DefaultTabViewModel vm) {
    return Container(
      height: context.mediumPlusValue,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(context.mediumValue)),
        child: buildCupertinoTabBar(vm, context),
      ),
    );
  }

  CupertinoTabBar buildCupertinoTabBar(DefaultTabViewModel vm, BuildContext context) {
    return CupertinoTabBar(
      currentIndex: vm.pageIndex,
      activeColor: Colors.white,
      inactiveColor: Colors.white70,
      backgroundColor: context.theme.accentColor,
      onTap: (value) {
        vm.pageController.animateToPage(value, duration: Duration(milliseconds: 100), curve: Curves.linear);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble)),
        BottomNavigationBarItem(icon: Icon(Icons.phone)),
        BottomNavigationBarItem(icon: Icon(Icons.camera_alt_outlined)),
        BottomNavigationBarItem(icon: Icon(Icons.blur_circular_sharp)),
      ],
    );
  }
}
