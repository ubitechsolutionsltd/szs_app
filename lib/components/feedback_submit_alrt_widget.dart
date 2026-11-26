import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'feedback_submit_alrt_model.dart';
export 'feedback_submit_alrt_model.dart';

/// Shown after feedback is sent.
class FeedbackSubmitAlrtWidget extends StatelessWidget {
  const FeedbackSubmitAlrtWidget({
    super.key,
    required this.onTapLogin,
  });

  final Future Function()? onTapLogin;

  @override
  Widget build(BuildContext context) {
    return AppDialogCard(
      imageAsset: 'assets/images/feedback_s_img.png',
      title: trs('mi20nny6'),
      message: trs('dqnmfycd'),
      actions: [
        AppButton(
          label: trs('9j6i9mj3'),
          onPressed: () async {
            await onTapLogin?.call();
          },
        ),
      ],
    );
  }
}
