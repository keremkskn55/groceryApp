import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app_firebase/screens/splash_screen.dart';
import 'package:grocery_app_firebase/services/shared_pref_order.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefOrder().createPrefObject();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SharedPrefOrder()),
      ],
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return OnBoard();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class OnBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SharedPrefOrder>(context, listen: false)
        .loadOrdersFromSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
