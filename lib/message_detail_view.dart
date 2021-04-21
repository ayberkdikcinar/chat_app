import 'package:chat_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

import 'core/components/send_text_button.dart';
import 'core/components/text_field_message.dart';

class MessageDetail extends StatelessWidget {
  const MessageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildAppBar(context),
          Padding(
            padding: context.paddingOnlyTop(context.height * 0.2),
            child: chatField(context),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('User Name And Photo'),
      backgroundColor: context.theme.accentColor,
      toolbarHeight: context.height * 0.15,
      actions: [
        iconButtonVideo,
        iconButtonPhone,
      ],
    );
  }

  Container chatField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(context.mediumValue), topRight: Radius.circular(context.mediumValue)),
        color: context.theme.highlightColor,
      ),
      child: Padding(
        padding: context.paddingOnlyTop(context.height * 0.05),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  return arrangeChatBody(true, context);
                },
              ),
            ),
            Padding(
              padding: context.paddingNormal,
              child: buildSendWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget arrangeChatBody(bool isOwner, BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Row(
        mainAxisAlignment: isOwner == true ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isOwner)
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 25,
            ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: isOwner == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                chatContainer(isOwner, context),
                context.emptySpaceLowWidth,
                Text("10:21"), // time
              ],
            ),
          )
        ],
      ),
    );
  }

  Container chatContainer(bool isOwner, BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(context.lowValue), color: isOwner == true ? context.theme.accentColor : context.theme.cardColor),
      padding: context.paddingLow,
      margin: context.paddingLow,
      child: Text('how are you matesdfsdfd sdfsdfsdfsdfsd sdfdsfsdfsdf sdfdsfdsfsd sdfdsf?'),
    );
  }

  Widget buildSendWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildSendTextField(context),
        ),
        context.emptySpaceLowWidth,
        TextButtonSend(
          onPressed: () {},
          icon: Icons.mic,
          color: context.theme.accentColor,
        ),
      ],
    );
  }

  Container buildSendTextField(BuildContext context) {
    return Container(
      height: 40,
      child: TextFieldMessage(
        borderRadius: context.height * 0.1,
        backgrounColor: context.theme.cardColor,
        hintText: '',
        prefixIcon: Icons.child_care_outlined,
        suffixIcon: Icons.attach_file_outlined,
      ),
    );
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
