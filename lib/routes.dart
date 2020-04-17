import 'package:flutter/material.dart';
import 'package:flutterfirebaseapp/containers/quote-list.dart';

import 'containers/create-quote-page.dart';

final routes = {
  '/': (BuildContext context) => new QuoteListPage(),
  '/create': (BuildContext context) => new CreateQuotePage()
};
