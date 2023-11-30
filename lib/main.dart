import 'package:employee_management/di.dart';
import 'package:employee_management/features/home/presentation/employees_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencyInjection();

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Data',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff1DA1F2),
        useMaterial3: true,
      ),
      home: const EmployeeScreen(),
    );
  }
}
