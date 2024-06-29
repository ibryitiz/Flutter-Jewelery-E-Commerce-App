import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:jewelry_app/constant/my_api_keys.dart';
import 'package:jewelry_app/constant/my_texts.dart';
import 'package:jewelry_app/constant/providers.dart';
import 'package:jewelry_app/firebase_options.dart';
import 'package:jewelry_app/views/get_started_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(
    MultiProvider(
      providers: MyProviders.getProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: MyTexts.instance.myFontFamily),
      debugShowCheckedModeBanner: false,
      home: const GetStartedPage(),
    );
  }
}
