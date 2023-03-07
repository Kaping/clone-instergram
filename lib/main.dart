import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(

            iconTheme: IconThemeData(color: Colors.white),

            appBarTheme: AppBarTheme(
                elevation: 1,
                color: Colors.white,
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
                actionsIconTheme: IconThemeData(color: Colors.black, size: 40)
            ),

            textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.red)
            )
          ),
          home: MyApp()
      )
  );
}
var a = TextStyle(color: Colors.black, fontSize: 25);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instargram'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.add_box_outlined),)
        ],
      ),
      body: Text('하이', style: a,),
      // Icon(Icons.star, color: Colors.blue),


    );
  }
}

