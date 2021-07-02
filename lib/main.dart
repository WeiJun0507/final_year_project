import 'package:final_year_project/model/member.dart';
import 'package:final_year_project/provider.dart';
import 'package:final_year_project/screens/wrapper/wrapper.dart';
import 'package:final_year_project/services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<Member>.value(
        value: AuthService().user,
        initialData: null,),
      ChangeNotifierProvider.value(value: AddPreOrderMenu()),
      ChangeNotifierProvider.value(value: ReservationInformation()),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
