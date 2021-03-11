import 'package:flutter/material.dart';

import 'config/routes.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData.light(),
        routes: routes,
        initialRoute: '/login',
      ),
    );
