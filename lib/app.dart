import 'package:cgi_assessment/core/theme/theme.dart';
import 'package:cgi_assessment/features/recipes/presentation/screens/recipes_list_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CGI Recipes',
      theme: AppTheme.darkThemeData,
      home: const RecipesListScreen(),
    );
  }
}
