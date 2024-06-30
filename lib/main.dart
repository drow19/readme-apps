import 'package:book_store_apps/di/components/service_locator.dart';
import 'package:book_store_apps/ui/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  runApp(const MyApp());
}