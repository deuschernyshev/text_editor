import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_editor/feature/app_layout/app_layout.dart';
import 'package:text_editor/feature/editor/bloc/editor_bloc.dart';
import 'package:text_editor/feature/explorer/bloc/explorer_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExplorerBloc>(
          create: (context) => ExplorerBloc(),
        ),
        BlocProvider<EditorBloc>(
          create: (context) => EditorBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppLayout(),
      ),
    );
  }
}
