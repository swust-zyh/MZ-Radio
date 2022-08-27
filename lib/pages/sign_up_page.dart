import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mzradio/pages/home_page.dart';
import 'package:mzradio/utils/theme.dart' as theme;
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 注册界面
 */
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String psd = "";
  String email = "";
  bool isShowPassWord = false;
  bool isShowCPassWord = false;
  GlobalKey<FormState> _SignInFormKey = new GlobalKey(); // 显示错误信息提醒
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var psdController = TextEditingController();
  var cpsdController = TextEditingController();

  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 23),
        child: new Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            new Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                ),
                width: 300,
                height: 300,
                child: buildSignUpTextForm()),
            new Positioned(
              child: new Center(
                child: new GestureDetector(
                  child: new Container(
                    margin: const EdgeInsets.all(1),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 42, right: 42),
                    decoration: new BoxDecoration(
                      gradient: theme.Theme.primaryGradient,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: new Text(
                      "SignUp",
                      style: new TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    if (_SignInFormKey.currentState.validate()) {
                      _getRegisterButtonPressed();
                    }
                  },
                ),
              ),
              top: 340,
            )
          ],
        ));
  }

  Widget buildSignUpTextForm() {
    return new Container(
      child: new Form(
          key: _SignInFormKey,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //用户名字
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                  child: new TextFormField(
                    controller: nameController,
                    decoration: new InputDecoration(
                        icon: new Icon(
                          FontAwesomeIcons.user,
                          color: Colors.black,
                        ),
                        hintText: "Name",
                        border: InputBorder.none),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Name can not be empty!";
                      }
                      value = "";
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
              new Container(
                height: 1,
                width: 250,
                color: Colors.grey[400],
              ),
              //邮箱
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                  child: new TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: "Email Address",
                        border: InputBorder.none),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    validator: (value) {
                      this.email = value;
                      if (value.isEmpty) {
                        return "Email can not be empty!";
                      }
                      value = "";
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
              new Container(
                height: 1,
                width: 250,
                color: Colors.grey[400],
              ),
              //密码
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                  child: new TextFormField(
                    controller: psdController,
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      border: InputBorder.none,
                      suffixIcon: new IconButton(
                          icon: new Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: showPassWord)),
                    obscureText: !isShowPassWord,
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    validator: (value) {
                      this.psd = value;
                      if (value == null || value.isEmpty || value.length < 6) {
                        return "Password must longer than 6!";
                      }
                      value = "";
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
              new Container(
                height: 1,
                width: 250,
                color: Colors.grey[400],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                  child: new TextFormField(
                    controller: cpsdController,
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "Confirm Password",
                      border: InputBorder.none,
                      suffixIcon: new IconButton(
                          icon: new Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: showCPassWord)),
                    obscureText: !isShowCPassWord,
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    validator: (value) {
                      if (value != this.psd) {
                        return "Confirm Password is not the same as Password";
                      }
                      value = "";
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
            ],
          )),
    );
  }

  showPassWord() {
    setState(() {
        isShowPassWord = !isShowPassWord;
    });
  }

  showCPassWord() {
    setState(() {
      isShowCPassWord = !isShowCPassWord;
    });
  }

  _getRegisterButtonPressed() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(this.email, this.psd);
    showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            content: Text("Register Successfully!"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                ),
                color: Colors.blue,
              ),
            ],
          );
        }
    );
    nameController.clear();
    emailController.clear();
    psdController.clear();
    cpsdController.clear();
  }
}
