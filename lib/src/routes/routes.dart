import 'package:carshop/src/features/categories/pages/categories_page.dart';
import 'package:carshop/src/features/categories/pages/category_page.dart';
import 'package:carshop/src/features/home/pages/home_page.dart';
import 'package:carshop/src/features/loader/pages/loader_page.dart';
import 'package:carshop/src/features/signin/pages/signin_page.dart';
import 'package:carshop/src/features/signup/pages/signup_page.dart';
import 'package:carshop/src/features/vehicles/pages/vehicle_page.dart';
import 'package:carshop/src/features/vehicles/pages/vehicles_page.dart';

import 'package:flutter/material.dart';

/// Rutas de paginas.
Map<String, WidgetBuilder> getPageRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    'loader': (BuildContext contex) => LoaderPage(),
    'signin': (BuildContext contex) => SigninPage(),
    'signup': (BuildContext contex) => SignupPage(),
    'home': (BuildContext contex) => HomePage(),
    'vehicles': (BuildContext contex) => VehiclesPage(),
    'vehicle': (BuildContext contex) => VehiclePage(),
    'categories': (BuildContext contex) => CategoriesPage(),
    'category': (BuildContext contex) => CategoryPage(),
  };
}
