import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:untitled1/pages/splash/splash_page.dart';
import 'package:untitled1/ui/home_page.dart';

import '../pages/account/Account_page.dart';
import '../pages/task/add_task_bar.dart';

class RouteHelper{
  static const String splash = '/splash-page';
  static const String initial = '/';
  static const String addtask = '/add-task';
  static const String dailytask = '/daily-task';
  static const String person = '/person';

  static String getSplash() => '$splash';
  static String getInitial() => '$initial';
  static String getAddTaskPage() => '$addtask';
  static String getDailyTaskPage() => '$dailytask';
  static String getPerson() => '$person';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: addtask,
        page: () {
          return AddTaskPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: dailytask,
        page: () {
          return AddTaskPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: person,
        page: () {
          return AccountPage();
        },
        transition: Transition.fadeIn),
  ];

}