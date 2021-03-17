import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webox/config/http_config.dart';
import 'package:webox/ui_components/app.dart';

void main() async {
  HttpOverrides.global = WeboxHttpOverrides();
  runApp(WeboxApp());
}
