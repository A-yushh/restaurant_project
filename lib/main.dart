import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/Screens/splashScreen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error loading .env file: $e');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return  MaterialApp(
          
          title: 'Nukkad Foods',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme()
            ),
        );
      },
    );
  }
}
