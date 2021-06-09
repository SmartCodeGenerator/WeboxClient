import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webox/config/http_config.dart';
import 'package:webox/repositories/order_item_repository.dart';
import 'package:webox/ui_components/app.dart';

void main() async {
  HttpOverrides.global = WeboxHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await OrderItemRepository.initialize();
  runApp(WeboxApp());
}
