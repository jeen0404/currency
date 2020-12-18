import 'package:currency/cubit/app_start_cubit.dart';
import 'package:currency/view/auth_ui/landing_page.dart';
import 'package:currency/view/route/authenticated_app_route.dart';
import 'package:currency/view/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppStartCubit _appStartCubit;

  @override
  void initState() {
    _appStartCubit = AppStartCubit();
    super.initState();
    _appStartCubit.add(AppStartCubitEvent.AppStartedAppStartCubitEvent);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStartCubit>(
        create: (context) => _appStartCubit,
        child: BlocBuilder<AppStartCubit, AppStartCubitState>(
          cubit: _appStartCubit,
          builder: (context, state) {
            if (state == AppStartCubitState.AuthenticatedAppStartCubitState)
              return Authenticated();
            else if (state ==
                AppStartCubitState.UnAuthenticatedAppStartCubitState)
              return UnAuthenticated();
            else {
              return SplashScreenApp();
            }
          },
        ));
  }
}

// UnAuthenticated MaterialApp
class UnAuthenticated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency',
        debugShowCheckedModeBanner:
        false, // removing debuging banner  // app title
        // Theme
        theme: ThemeData.light(), // flutter defult light themedata
        darkTheme: ThemeData.dark(), // flutter defult dark theme for dark mode
        home: LandingScreen());
  }
}

// AuthenticatedApp or main app
class Authenticated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency',
      debugShowCheckedModeBanner:
      false, // removing debuging banner  // app title
      // Theme
      theme: ThemeData.light().copyWith(
          appBarTheme: ThemeData.light().appBarTheme.copyWith(
              color: ThemeData.light().scaffoldBackgroundColor,
              textTheme: ThemeData.light().textTheme,
              iconTheme: ThemeData.light().iconTheme,
              elevation: 0.2
          ),
          tabBarTheme: ThemeData.light().tabBarTheme.copyWith(labelColor: ThemeData.light().colorScheme.onSurface)
      ), // flutter defult light themedata
      darkTheme: ThemeData.dark().copyWith(
          appBarTheme: ThemeData.dark().appBarTheme.copyWith(elevation: 0.2)
      ), // flutter defult dark theme for dark mode

      // assigning route setting to send it to main screen
      onGenerateRoute: (RouteSettings settings) => authenticatedAppRoute(settings),
    );
  }
}

// Splash screen app
class SplashScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency',
        debugShowCheckedModeBanner:
        false, // removing debuging banner  // app title
        // Theme
        theme: ThemeData.light(), // flutter defult light themedata
        darkTheme: ThemeData.dark(), // flutter defult dark theme for dark mode
        home: SplashScreen());
  }
}
