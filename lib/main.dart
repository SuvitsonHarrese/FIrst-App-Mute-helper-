import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mute_help/ad/ad_service.dart';
import 'package:mute_help/bloc/travel_bloc.dart';
import 'package:mute_help/flashscreen.dart';
import 'bloc/info_bloc.dart';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final adService = AdService(MobileAds.instance);
  // GetIt.instance.registerSingleton<AdService>(adService);

  // await adService.init();
  
  runApp(MyApp());
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TravelInfoBloc>(create: (context) => TravelInfoBloc()),
        BlocProvider<InfoBloc>(
          create: (context) => InfoBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:SplashScreen(),
      ),
    );
  }
}
