import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';

class DefaulTabView extends StatefulWidget {
  const DefaulTabView({Key? key}) : super(key: key);

  @override
  _DefaulTabViewState createState() => _DefaulTabViewState();
}

class _DefaulTabViewState extends State<DefaulTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          onPageChanged: (value) {
            setState(() {});
          },
          children: [
            HomeView(),
            Text('aa'),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: CupertinoTabBar(
                backgroundColor: Colors.black,
                onTap: (value) {},
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home)),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite_border)),
                  BottomNavigationBarItem(icon: Icon(Icons.home)),
                  BottomNavigationBarItem(icon: Icon(Icons.home)),
                ],
              ),
            ),
          ),
        ));
  }
}
