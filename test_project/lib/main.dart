import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/api/app_api.dart';
import 'package:test_project/bloc/contact_cubit.dart';
import 'package:test_project/pages/contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ContactCubit(AppApi()),
        child: const ContactPage(),
      ),
    );
  }
}
