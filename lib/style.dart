import 'package:flutter/material.dart';

var _var1; //if use under bar,like '_varName', then you can't use this var other files. 언더바 쓰면 다른 파일에서 못쓰게 됨

var theme = ThemeData(

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey,

      )
    ),

    iconTheme: IconThemeData(color: Colors.black),

    appBarTheme: AppBarTheme(
      elevation: 1,
      color: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 40)
    ),


    textTheme: TextTheme(
      bodyText2: TextStyle(color: Colors.black)
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,

    )
);