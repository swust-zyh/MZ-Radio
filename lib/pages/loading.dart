import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mzradio/pages/home_page.dart';
import 'package:mzradio/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mzradio/utils/islogin.dart' as ilg;

class LoadPage extends StatefulWidget {
  @override
  _LoadPageState createState() => _LoadPageState();
}

// 图片嵌套文字
class _LoadPageState extends State<LoadPage> {
  var page;
  var flag;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState(){
    super.initState();
    get();
    new Timer(new Duration(seconds: 3), () {
      // 跳转到下个页面，并且销毁当前页面
      print(this.flag);
      if(this.flag != null) page = new HomePage();
      else page = new LoginPage();
      Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }), (route) => route == null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: new SingleChildScrollView(
          child: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/loading.jpg',
                ),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            [
              40.heightBox,
              "⭐Start your music travel⭐".text.italic.semiBold.white.make(),
              "MZ Radio".text.xl6.bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.red),
              600.heightBox,
              5000.widthBox,
              "MZ Radio Version 2.0.0".text.italic.semiBold.white.make(),
              "Copyright © 2021 Mike Zheng. All Rights Reserved.".text.italic.semiBold.white.make(),
              "csmikezheng@gmail.com".text.italic.semiBold.white.make(),
            ].vStack(alignment: MainAxisAlignment.start),
          ],
        ),
      )),
    ));
  }

  get() async{
    _prefs.then((prefs){
      this.flag = prefs.getString(ilg.islogin.login);
      print(prefs.getString(ilg.islogin.login));
    });
  }
}
