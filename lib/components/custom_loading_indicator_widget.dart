import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'custom_loading_indicator_model.dart';
export 'custom_loading_indicator_model.dart';

class CustomLoadingIndicatorWidget extends StatefulWidget {
  const CustomLoadingIndicatorWidget({super.key});

  @override
  State<CustomLoadingIndicatorWidget> createState() =>
      _CustomLoadingIndicatorWidgetState();
}

class _CustomLoadingIndicatorWidgetState
    extends State<CustomLoadingIndicatorWidget> with TickerProviderStateMixin {
  late CustomLoadingIndicatorModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomLoadingIndicatorModel());

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: FFAppState().isLoading,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).black20,
          ),
          child: Icon(
            Icons.play_circle_outline,
            color: FlutterFlowTheme.of(context).primary,
            size: 90.0,
          ).animateOnPageLoad(animationsMap['iconOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
