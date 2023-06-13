import 'package:flutter/material.dart';
import 'package:ist/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env'); // 環境変数をロード
  runApp(const App());
}
