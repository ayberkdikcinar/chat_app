import 'core/localization/locale_keys.g.dart';
import 'service/firestore_db_service.dart';
import 'user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(LocaleKeys.not_found.tr()), //Text('NOT FOUND'),
      ),
    );
  }
}
