import 'package:demo/src/item-details.dart';

import 'splashscreen.dart';
import 'src/home.dart';

final appRoutes = {
  '/': (context) => AfterSplash(),
  '/home': (context) => MyHomePage(title: 'Home'),
  '/item-details': (context) => MyItemDetails(title: 'Item Details'),
};
