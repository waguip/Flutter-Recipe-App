import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/repositories/category_repository.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/favorites_repository.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';
import 'package:provider/provider.dart';

late final FirebaseApp app;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => CategoryRepository()),
        ChangeNotifierProvider(create: (context) => FavoritesRepository()),
      ],
      child: MaterialApp(
        home: AuthCheck(),
        theme: ThemeData.dark(),
      ),
    ),
  );
}
