import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instargram_clone_coding/shop.dart';

import './style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=> Store1()),
          ChangeNotifierProvider(create: (c)=> Store2()),
        ],
        child: MaterialApp(
            theme: style.theme,
            home: MyApp()
        ),
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
  var userImage;
  var userContent;

  saveData() async{
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'Yeom');
    // storage.getString('name');
  }

  addMyData(){
    var myData = {
      'id' : data.length,
      'image' : userImage,
      'likes' : 5,
      'date' : 'July 25',
      'content' : userContent,
      'liked' : false,
      'user' : 'Yeom'
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }

  addData(a){
    setState(() {
      data.add(a);
    });
  }

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
              onPressed: () async{
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                // var image = await picker.pickImage(source: ImageSource.camera);
                // var image = await picker.pickVideo(source: ImageSource.camera);
                if(image != null){
                  setState(() {
                    userImage = File(image.path);
                  });
                }

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Upload(userImage : userImage,
                    setUserContent: setUserContent, addMyData: addMyData)),
                );
              },
              icon: Icon(Icons.add_box_outlined),
          )
        ],
      ),
      body: [Home(data: data, addData: addData), Shop()][tab],

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

class Home extends StatefulWidget {
  const Home({Key? key, this.data, this.addData}) : super(key: key);
  final data;
  final addData;



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var scroll = ScrollController();

  getMore() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    if (result.statusCode == 200){
      var result2 = jsonDecode(result.body);
      widget.addData(result2);
    } else {
      throw Exception('failed get');
    }

  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        getMore();
      }
    });
  }

  @override

  Widget build(BuildContext context) {

    if (widget.data.isNotEmpty) {
      return ListView.builder(itemCount: widget.data.length, controller: scroll, itemBuilder: (c, i){
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.data[i]['image'].runtimeType == String
                ? Image.network(widget.data[i]['image'])
                  : Image.file(widget.data[i]['image']),
              // Image(image: AssetImage("example.png")),
              Text('좋아요 ${widget.data[i]['likes']}개', style: TextStyle(fontWeight: FontWeight.bold),),

              GestureDetector(
                  child: Text(widget.data[i]['user']),
                onTap: (){
                  Navigator.push(context,
                    CupertinoPageRoute(builder: (c) => Profile() )
                  );
                }, //onDoubleTap
              ),
              Text(widget.data[i]['date'].toString()),
              Text(widget.data[i]['content'].toString())

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


class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData}) : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar( actions: [
          IconButton(onPressed: (){
            addMyData();
          }, icon: Icon(Icons.send))
        ],),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(userImage),
            Text('이미지업로드화면'),
            TextField(onChanged: (text){
              setUserContent(text);
            },),
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
    );
  }
}

class Store2 extends ChangeNotifier{
  var name = 'what the';
}

class Store1 extends ChangeNotifier {
  var name = 'yeom_sooo';
  var follower = 0;
  var friend = false;
  var profileImage = [];

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();
  }
  addFollower(){
    if (friend == false){
      follower++;
      friend = true;
    } else{
      follower--;
      friend = false;
    }

    notifyListeners();
  }
}


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<Store1>().getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name),),
      body: CustomScrollView (
        slivers: [
          SliverToBoxAdapter(child: ProfileHeader()),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                      (c, i)=>Image.network(context.watch<Store1>().profileImage[i]),
                      childCount: context.watch<Store1>().profileImage.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)
              ),
        ],
      ),


      //ProfileHeader()
        //Text('프로필 페이지'),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
        ),
        Text('팔로워 ${context.watch<Store1>().follower}명'),
        ElevatedButton(onPressed: (){
          context.read<Store1>().addFollower();
        }, child: Text('팔로우')),
        // ElevatedButton(onPressed: (){
        //   context.read<Store1>().getData();
        // }, child: Text('사진가져옴'))
      ],
    );
  }
}

