import 'package:dars_12/controllers/location_controller.dart';
import 'package:dars_12/firebase_options.dart';
import 'package:dars_12/services/location_services.dart';
import 'package:dars_12/views/screens/home_screen.dart';
import 'package:dars_12/views/screens/warning_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await LocationServices.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LocationController();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LocationServices.permissionStatus == PermissionStatus.granted?const HomeScreen():const WarningScreen(),
      ),
    );
  }
}
