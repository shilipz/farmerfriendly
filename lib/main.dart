import 'package:cucumber_app/presentation/presentation_logic/quantity_button/quantity_button_bloc.dart';
import 'package:cucumber_app/presentation/views/contact_details/contact_details.dart';
import 'package:cucumber_app/presentation/views/product/products.dart';
import 'package:cucumber_app/presentation/views/signing/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'utils/screen_size.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MyApp());
}

final screenWidth = ScreenSize.screenWidth;
final screenHeight = ScreenSize.screenHeight;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuantityButtonBloc(),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: MaterialApp(
        routes: {
          // '/addproducts': (context) => const AddProducts(),
          '/contact_details': (context) => ContactDetails(),
        },
        home: Login(),
      ),
    );
  }
}
