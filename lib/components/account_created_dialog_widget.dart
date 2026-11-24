import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'account_created_dialog_model.dart';
export 'account_created_dialog_model.dart';

/// Shown after sign-up.
class AccountCreatedDialogWidget extends StatelessWidget {
  const AccountCreatedDialogWidget({
    super.key,
    required this.onTapLogin,
  });

  final Future Function()? onTapLogin;

  @override
  Widget build(BuildContext context) {
    return AppDialogCard(
      imageAsset: 'assets/images/account_created_img.png',
      title: trs('xcjoq77j'),
      message: trs('ifwfe1wl'),
      actions: [
        AppButton(
          label: trs('zrgrvxw3'),
          onPressed: () async {
            await onTapLogin?.call();
          },
        ),
      ],
    );
  }
}
