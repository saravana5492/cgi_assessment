import 'package:cgi_assessment/app.dart';
import 'package:cgi_assessment/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:cgi_assessment/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<RecipeBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
