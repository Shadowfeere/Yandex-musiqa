import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiqa_uia1/cubit/file_cubit.dart';
import 'package:musiqa_uia1/cubit/video_cubit.dart';
import 'package:musiqa_uia1/router/app_router.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FileCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: 'Tik tok',
      initialRoute: "/pick_file",
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
