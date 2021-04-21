import 'package:flutter/material.dart';

import 'core/components/custom_icon_button.dart';
import 'core/extension/context_extension.dart';
import 'message_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Text(
        'Chatttelr',
        style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.w800),
      ),
      actions: [
        CustomIconButton(icon: Icons.search, onPressed: () {}),
        CustomIconButton(icon: Icons.view_list, onPressed: () {}),
      ],
    );
  }

  Widget scaffoldBody(BuildContext context) {
    return Column(
      children: [
        buildAppBar(context),
        Expanded(
          child: ListView(
            children: [
              Text(
                'Activity',
                style: context.textTheme.headline6,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: context.theme.accentColor,
                        radius: 35,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                          radius: 32,
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                child: Text('Messages'),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MessageDetail(),
                )),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Text('b');
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
