import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];


  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    if (result.statusCode == 200){
      var result2 = jsonDecode(result.body);

      setState(() {
        data = result2;
      });

    } else {
      throw Exception('failed get');
    }

  }

  @override
  void initState()  {
    super.initState();
    getData();
  }

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
      body: [Home(data: data), Text("샵페이지")][tab],

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

class Home extends StatelessWidget {
  const Home({Key? key, this.data}) : super(key: key);
  final data;
  @override

  Widget build(BuildContext context) {

    if (data.isNotEmpty) {
      return ListView.builder(itemCount: 3, itemBuilder: (c, i){
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Image.network(data[i]['image'].toString()),
              // Image(image: AssetImage("example.png")),
              Text('likes ' + data[i]['likes'].toString(), style: TextStyle(fontWeight: FontWeight.bold),),
              Text(data[i]['user'].toString()),
              Text(data[i]['content'].toString())
            ]
        );
      });
    } else{
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}



