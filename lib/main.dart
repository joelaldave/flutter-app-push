import 'package:flutter/material.dart';
import 'package:push_app/src/pages/home_page.dart';
import 'package:push_app/src/pages/mensaje_page.dart';
import 'package:push_app/src/providers/push_notifications_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final pushProvider = new PushNotificationsProvider();

    pushProvider.initNotifications();

    pushProvider.mensajesStream.listen((argumento) {
      //print('argumento desde main $argumento');
      //Navigator.pushNamed(context, 'mensaje');
      navigatorKey.currentState.pushNamed('mensaje', arguments: argumento);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Material App',
      home: HomePage(),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mensaje': (BuildContext context) => MensajePage(),
      },
    );
  }
}
