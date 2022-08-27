import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mzradio/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mzradio/utils/islogin.dart' as ilg;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List tags = ['travel', 'urban', 'fashion', 'music', 'lifestyle'];
  List categories = [
    'Life',
    'Love Songs',
    'My Song Lists',
    'Collectible Song Lists',
    'Comments',
  ];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff09031D),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Color(0xff09031D),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: (){
                  updatelogin();
                },
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 7),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Michaela',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.location_on,
                                    color: Colors.white, size: 17),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text('Los Angeles, USA',
                                      style: TextStyle(
                                          color: Colors.white,
                                          wordSpacing: 2,
                                          letterSpacing: 4)),
                                )
                              ],
                            ))
                      ],
                    )),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(
                    right: 38, left: 38, top: 15, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('17k',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Text('followers',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      width: 0.2,
                      height: 22,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('387',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Text('following',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      width: 0.2,
                      height: 22,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(33)),
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.greenAccent],
                              begin: Alignment.bottomRight,
                              end: Alignment.centerLeft)),
                      child: Text('online',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
            Container(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        border: Border.all(color: Colors.white12)),
                    margin: EdgeInsets.only(right: 13),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 13, bottom: 5, right: 20, left: 20),
                      child: Text(tags[index],
                          style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    color: Color(0xffEFEFEF),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(34))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 33, right: 25, left: 25),
                      child: Text(
                        'Protfllio',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 33),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 25, left: 25),
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 17, top: 3),
                            child: index == 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        categories[index],
                                        style: TextStyle(
                                            color: Color(0xff434AE8),
                                            fontSize: 19),
                                      ),
                                      CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Color(0xff434AE8),
                                      )
                                    ],
                                  )
                                : Text(categories[index],
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.9),
                                        fontSize: 19)),
                          );
                        },
                      ),
                    ),
                    Expanded(
                        child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.only(right: 25, left: 25),
                            height: 380,
                            child: StaggeredGridView.countBuilder( // 瀑布流
                              crossAxisCount: 4,
                              itemCount: 8,
                              itemBuilder: (BuildContext context, int index) => Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  child: Image.asset('assets/img${index+1}.jpg', fit: BoxFit.cover,),
                                ),
                              ),
                              staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(2, index.isEven ? 3 : 1),
                              mainAxisSpacing: 9,
                              crossAxisSpacing: 8,
                            ),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ));
  }

  updatelogin() async{
    final SharedPreferences prefs = await _prefs;
    showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to exit this account?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  prefs.setString(ilg.islogin.login, null);
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (BuildContext context) {
                    return new LoginPage();
                  }), (route) => route == null);
                },
                child: Text(
                  "Sure",
                ),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                ),
                color: Colors.blue,
              )
            ],
          );
        }
    );
  }
}
