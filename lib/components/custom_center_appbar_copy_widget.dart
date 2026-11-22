import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom_center_appbar_copy_model.dart';
export 'custom_center_appbar_copy_model.dart';

class CustomCenterAppbarCopyWidget extends StatefulWidget {
  const CustomCenterAppbarCopyWidget({
    super.key,
    String? title,
    required this.backIcon,
    required this.addIcon,
    required this.onTapAdd,
  }) : this.title = title ?? 'Title';

  final String title;
  final bool? backIcon;
  final bool? addIcon;
  final Future Function()? onTapAdd;

  @override
  State<CustomCenterAppbarCopyWidget> createState() =>
      _CustomCenterAppbarCopyWidgetState();
}

class _CustomCenterAppbarCopyWidgetState
    extends State<CustomCenterAppbarCopyWidget> {
  late CustomCenterAppbarCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustomCenterAppbarCopyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 79.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Builder(
                builder: (context) {
                  if (widget.backIcon == false) {
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.safePop();
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            border: Border.all(color: FlutterFlowTheme.of(context).borderColor, width: 0.8),
                            shape: BoxShape.circle,
                          ),
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/arrow_back_white_ic.svg',
                      colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                                fit: BoxFit.contain,
                                alignment: Alignment(0.0, 0.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 0.0,
                      height: 0.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Text(
                valueOrDefault<String>(
                  widget.title,
                  'Title',
                ),
                maxLines: 1,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SF Pro Display',
                      color: FlutterFlowTheme.of(context).tertiary,
                      fontSize: 28.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Builder(
                builder: (context) {
                  if (widget.addIcon == true) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await widget.onTapAdd?.call();
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                          border: Border.all(color: FlutterFlowTheme.of(context).borderColor, width: 0.8),
                            shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: SvgPicture.asset(
                            'assets/images/more_white_ic.svg',
                      colorFilter: ColorFilter.mode(FlutterFlowTheme.of(context).tertiary, BlendMode.srcIn),
                            fit: BoxFit.contain,
                            alignment: Alignment(0.0, 0.0),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: 0.0,
                      height: 0.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
