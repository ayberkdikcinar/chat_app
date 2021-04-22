import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/components/button/send_text_button.dart';
import '../../core/components/text/text_field_message.dart';
import '../../core/extension/context_extension.dart';
import '../../core/localization/locale_keys.g.dart';
import '../../user_model.dart';
import '../model/message_model.dart';
import '../viewmodel/message_viewmodel.dart';

class MessageDetail extends StatelessWidget {
  final UserModel user;
  const MessageDetail({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewmodel = MessageViewModel();
    return Scaffold(
      body: Stack(
        children: [
          buildAppBar(context),
          buildPaddingChatField(context, viewmodel),
        ],
      ),
    );
  }

  Padding buildPaddingChatField(BuildContext context, MessageViewModel viewmodel) {
    return Padding(
      padding: context.paddingOnlyTop(context.ultraHighValue),
      child: chatField(context, viewmodel),
    );
  }

  Container chatField(BuildContext context, MessageViewModel viewmodel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(context.mediumValue), topRight: Radius.circular(context.mediumValue)),
        color: context.theme.highlightColor,
      ),
      child: Padding(
        padding: context.paddingOnlyTop(context.mediumValue),
        child: chatFieldcolumn(viewmodel, context),
      ),
    );
  }

  Column chatFieldcolumn(MessageViewModel viewmodel, BuildContext context) {
    return Column(
      children: [
        Expanded(child: streamBuilderForChat(viewmodel)),
        Padding(padding: context.paddingNormal, child: buildBottomContainerWidget(context, viewmodel)),
      ],
    );
  }

  StreamBuilder<List<Message>> streamBuilderForChat(MessageViewModel viewmodel) {
    return StreamBuilder<List<Message>>(
        stream: viewmodel.getAllMessagesBetween('${user.id}', '0'),
        builder: (context, snapshot) {
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              if (snapshot.hasData) {
                return arrangeChatBody(context, snapshot.data?[index]);
              } else {
                return Text('');
              }
            },
          );
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          appbarUserCircleAvatar(context),
          context.emptySpaceLowWidth,
          appbarNameStatusColumn(context),
        ],
      ),
      backgroundColor: context.theme.accentColor,
      toolbarHeight: context.highPlusValue,
      actions: [
        iconButtonVideo,
        iconButtonPhone,
      ],
    );
  }

  Column appbarNameStatusColumn(BuildContext context) {
    return Column(
      children: [
        Text(user.name ?? ''),
        context.emptySpaceLowHeight,
        Text(LocaleKeys.status.tr(), style: context.textTheme.caption!.copyWith(color: context.theme.highlightColor)),
      ],
    );
  }

  CircleAvatar appbarUserCircleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(user.photo ?? ''),
      radius: context.mediumValue,
    );
  }

  Widget arrangeChatBody(BuildContext context, Message? message) {
    if (message == null) {
      return Container();
    }
    return Padding(
      padding: context.paddingLow,
      child: Row(
        mainAxisAlignment: message.isOwner == true ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!message.isOwner!) messageCircleAvatar(context),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: message.isOwner == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                chatContainer(message, context),
                context.emptySpaceLowWidth,
                Text(formatDate(message.date!.toDate(), [HH, ':', nn])), // time
              ],
            ),
          )
        ],
      ),
    );
  }

  CircleAvatar messageCircleAvatar(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(user.photo ?? ''),
      radius: context.normalPlus,
    );
  }

  Container chatContainer(Message? message, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.lowValue), color: message?.isOwner == true ? context.theme.accentColor : context.theme.hintColor),
      padding: context.paddingLow,
      margin: context.paddingLow,
      child: Text(message?.body ?? '',
          style: message?.isOwner == false ? context.textTheme.bodyText1 : context.textTheme.bodyText1!.copyWith(color: context.theme.highlightColor)),
    );
  }

  Widget buildBottomContainerWidget(BuildContext context, MessageViewModel viewmodel) {
    return Row(
      children: [
        Expanded(
          child: buildSendTextField(context, viewmodel),
        ),
        context.emptySpaceLowWidth,
        TextButtonSend(
          onPressed: () => onSendPressed(viewmodel),
          icon: Icons.mic,
          color: context.theme.accentColor,
        )
      ],
    );
  }

  Container buildSendTextField(BuildContext context, MessageViewModel viewmodel) {
    return Container(
      height: context.mediumPlusValue,
      child: TextFieldMessage(
        borderRadius: context.highValue,
        backgrounColor: context.theme.hintColor,
        hintText: '',
        prefixIcon: Icons.child_care_outlined,
        suffixIcon: Icons.attach_file_outlined,
        onChanged: (value) {
          viewmodel.setUserMessage(value);
        },
      ),
    );
  }

  Future<void> onSendPressed(MessageViewModel viewmodel) async {
    await viewmodel.saveMessage(Message(body: viewmodel.userMessage, to: user.id, from: '0', date: Timestamp.now()));
  }

  IconButton get iconButtonPhone {
    return IconButton(
      icon: Icon(Icons.phone),
      onPressed: () {},
    );
  }

  IconButton get iconButtonVideo {
    return IconButton(
      icon: Icon(Icons.photo_camera_front),
      onPressed: () {},
    );
  }
}
