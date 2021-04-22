import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../core/components/button/custom_icon_button.dart';
import '../../core/components/card/custom_card_widget.dart';
import '../../core/components/circle_avatar/custom_circle_avatar.dart';
import '../../core/constants/navigation_constants.dart';
import '../../core/extension/context_extension.dart';
import '../../core/localization/locale_keys.g.dart';
import '../../core/navigation/navigation_service.dart';
import '../viewmodel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel();

    return Observer(builder: (_) {
      if (viewModel.state == ViewState.Busy) {
        return Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        body: scaffoldBody(context, viewModel),
      );
    });
  }

  Widget scaffoldBody(BuildContext context, HomeViewModel vm) {
    return Column(
      children: [
        paddingAppbar(context),
        Expanded(
          child: bodyListView(context, vm),
        ),
      ],
    );
  }

  Padding paddingAppbar(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyTop(context.normalPlus),
      child: buildAppBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: context.mediumPlusValue,
      title: Text(
        LocaleKeys.app_name.tr(),
        style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.w800),
      ),
      actions: [
        CustomIconButton(icon: Icons.search, onPressed: () {}),
        CustomIconButton(icon: Icons.view_list, onPressed: () {}),
      ],
    );
  }

  ListView bodyListView(BuildContext context, HomeViewModel vm) {
    return ListView(
      children: [
        paddingActivityText(context),
        storyContainer(context, vm),
        paddingMessagesText(context),
        chatListView(vm),
      ],
    );
  }

  Padding paddingMessagesText(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Text(LocaleKeys.messages, style: context.textTheme.headline6).tr(),
    );
  }

  ListView chatListView(HomeViewModel vm) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vm.userList!.length,
      itemBuilder: (context, index) {
        return CustomCardWidget(
          userModel: vm.userList![index],
          messageModel: vm.lastMessageList?[vm.userList![index].id],
          onPressed: () {
            NavigationService.instance.navigateToPage(path: NavigationConstants.MESSAGE_DETAIL, data: vm.userList![index]);
          },
        );
      },
    );
  }

  Padding paddingActivityText(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyLeft(context.normalValue),
      child: Text(
        LocaleKeys.activity.tr(),
        style: context.textTheme.headline6,
      ),
    );
  }

  Widget storyContainer(BuildContext context, HomeViewModel vm) {
    return Padding(
      padding: context.paddingOnlyLeft(context.lowValue),
      child: Container(
        height: context.highPlusValue,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: vm.userList!.length,
          itemBuilder: (context, index) {
            return circleAvatarWithPadding(context, vm, index);
          },
        ),
      ),
    );
  }

  Padding circleAvatarWithPadding(BuildContext context, HomeViewModel vm, int index) {
    return Padding(
      padding: context.paddingLow,
      child: CustomCircleAvatar(
        imageUrl: vm.userList![index].photo!,
        firstRadius: 35,
        secRadius: 33,
      ),
    );
  }
}
