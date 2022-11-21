import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/helper/dbhelper.dart';
import 'package:untitled1/pages/account/Account_page.dart';
import 'package:untitled1/pages/login/login_page.dart';
import 'package:untitled1/pages/task/add_task_bar.dart';
import 'package:untitled1/pages/task/daily_task.dart';
import 'package:untitled1/pages/task/main_home.dart';
import 'package:untitled1/services/task_service.dart';
import 'package:untitled1/services/theme_services.dart';
import 'package:untitled1/services/user_service.dart';
import 'package:untitled1/ui/theme.dart';

import 'pages/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_context)=> TaskProvider(), lazy: false),
          ChangeNotifierProvider(create: (_context)=> UserServiceProvider(), lazy: false)
        ]
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Milestone',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '_splashScreen',
      routes: {
        '_homeTask':(_)=>MainTask(),
        '_splashScreen':(_)=>SplashScreen(),
        '_addTask':(_)=>AddTaskPage(),
        '_dailyTask':(_)=>DailyTask(),
        '_loginScreen':(_)=>LoginPostulant(),
        '_accountScreen':(_)=>AccountPage(),
      },
    );
  }
}


