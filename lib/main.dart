import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_pm/common/helper/router/app_router.dart';
import 'package:my_pm/presentation/splash/bloc/splash_cubit.dart';
import 'package:my_pm/service_locator.dart';

import 'core/configs/style/global_colors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocProvider(
      create: (context) => SplashCubit()..appStarted(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
