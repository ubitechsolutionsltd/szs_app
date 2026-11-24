import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'app_toast.dart';

/// True once the user has actually logged in. Guests may still browse
/// everything; this only gates actions that need an account.
bool get isLoggedIn => FFAppState().isLogin;

/// Tells the guest why they're being sent to login, then sends them there.
void promptLogin(BuildContext context, [String message = 'Tafadhali ingia kwanza ili kuendelea.']) {
  AppToast.info(context, message);
  context.pushNamed(LoginPageWidget.routeName);
}
