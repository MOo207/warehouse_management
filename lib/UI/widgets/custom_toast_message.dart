import 'package:flutter/services.dart';

const platform = MethodChannel("toast.flutter.io/toast");

Future showToastMessage(String message) async {
  await platform.invokeMethod("showToast", {"text": message});
}