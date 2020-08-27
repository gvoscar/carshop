import 'package:carshop/src/configs/user_preferences.dart';
import 'package:carshop/src/providers/session_provider.dart';
import 'package:carshop/src/providers/theme_change_provider.dart';
import 'package:carshop/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new UserPreferences();
  prefs.initUserPreferences();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(
            create: (context) => ThemeChangeProvider(ThemeData.light())),
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarShop',
      initialRoute: 'loader',
      theme: themeProvider.getTheme(),
      darkTheme: ThemeData.dark(),
      routes: getPageRoutes(context),
    );
  }
}
