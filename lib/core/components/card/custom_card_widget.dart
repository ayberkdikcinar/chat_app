import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../message_detail/model/message_model.dart';
import '../../../user_model.dart';
import '../../extension/context_extension.dart';
import '../../extension/dateTime_extension.dart';
import '../../localization/locale_keys.g.dart';
import '../circle_avatar/custom_circle_avatar.dart';

class CustomCardWidget extends StatelessWidget {
  final UserModel userModel;
  final VoidCallback onPressed;
  final Message? messageModel;
  const CustomCardWidget({
    Key? key,
    required this.userModel,
    required this.onPressed,
    this.messageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: buildListTile(context),
    );
  }

  ListTile buildListTile(BuildContext context) {
    return ListTile(
      onTap: () => onPressed(),
      leading: CustomCircleAvatar(imageUrl: userModel.photo ?? ''),
      title: Text(userModel.name ?? '', style: context.textTheme.button),
      subtitle: Text(messageModel?.body ?? ''),
      trailing: buildColumn(context),
    );
  }

  Column buildColumn(BuildContext context) {
    if (messageModel!.date != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(messageModel!.date!.toDate().gettimeDifference), //messageModel!.date!.toDate()
          context.emptySpaceLowHeight,
          CircleAvatar(
            backgroundColor: context.theme.accentColor,
            radius: context.lowPlus,
            child: buildText(context),
          )
        ],
      );
    }
    return Column();
  }

  Text buildText(BuildContext context) {
    return Text(LocaleKeys.number.tr(), style: TextStyle(color: context.theme.highlightColor));
  }
}
