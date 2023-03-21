import 'package:flutter/material.dart';
import './style.dart' as style;

void main() {
  runApp(
      MaterialApp(
          theme: style.theme,
          home: MyApp()
      )
  );
}
var a = TextStyle(color: Colors.black, fontSize: 25);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Column(
      children: [
        Image(image: AssetImage("images/example.png")),
        Text("난데요"),
        Text("좋아요가 많아요")
      ],
    );
  }
}
class _MyAppState extends State<MyApp> {

  var tab = 0;



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
      body: Column(
        children: [
          Image.asset('assets/example.png'),
        ],
      ),
      // ,[Text("집"), Text("마트")][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tab = i;
          });
        },
        items: [
           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '샵'),
        ],
      ),
    );

  }
}


