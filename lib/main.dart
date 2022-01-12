import 'package:community/navbar/dashboard.dart';
import 'package:community/object_detection/home.dart';
import 'package:community/onboarding_screen/screen_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:community/providers/user_provider.dart';
import 'package:community/responsive/mobile_screen_layout.dart';
import 'package:community/responsive/responsive_layout.dart';
import 'package:community/responsive/web_screen_layout.dart';
import 'package:community/screens/login_screen.dart';
import 'package:community/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:community/object_detection/camera.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBjQST7C9aj-4eJgiJaJob4qmGb7ExKhV0",
          authDomain: "proplanttest1.firebaseapp.com",
          appId: "1:235195994211:web:ae7f56d92241e33d4ba856",
          messagingSenderId: "235195994211",
          projectId: "proplanttest1",
          storageBucket: 'proplanttest1.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  await Firebase.initializeApp();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proplant',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return OnboardScreenOne();
            // return LoginScreen();
          },
        ),
      ),
    );
  }
}
