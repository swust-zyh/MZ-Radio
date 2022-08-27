import 'package:mzradio/model/radio.dart';
import 'package:mzradio/pages/my.dart';
import 'package:mzradio/utils/ai_utils.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios;
  MyRadio _selectedRadio;
  Color _selectedColor;
  bool _isPlaying = false;
  MyRadio isPlayingRadio;

  // 上方语音命令提示漂浮块
  final sugg = [
    "Play",
    "Stop",
    "Play rock music",
    "Play 94 FM",
    "Next Channel",
    "Play 101 FM",
    "Pause",
    "Previous Radio",
    "Play pop music",
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupAlan();
    fetchRadios();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  // 调用Alan
  setupAlan() {
    AlanVoice.addButton(
        "5e85592e2e6fd9757389ef4dd7e0850d2e956eca572e1d8b807a3e2338fdd0dc/stage", // integration
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  String pp = "";
  int cnt = 0;
  _handleCommand(Map<String, dynamic> response) {
    print(response["command"]);
    // 解决执行两次指令
    if (response["command"] == pp && cnt == 0) {
      cnt = 1;
      return;
    } else {
      pp = response["command"];
      cnt = 0;
    }

    switch (response["command"]) {
      case "play":
        _playMusic(_selectedRadio.url);
        break;
      case "play_channel": // √
        final id = response["id"];
        MyRadio newRadio = radios.firstWhere((element) => element.id == id);
        radios.remove(newRadio);
        radios.insert(0, newRadio);
        _playMusic(newRadio.url);
        break;
      case "stop":
        _audioPlayer.release();
        break;
      case "next": // 下个
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index + 1 > radios.length) {
          newRadio = radios.firstWhere((element) => element.id == 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        } else {
          newRadio = radios.firstWhere((element) => element.id == index + 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;
      case "prev": // 上个
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index - 1 <= 0) {
          newRadio =
              radios.firstWhere((element) => element.id == radios.length - 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        } else {
          newRadio = radios.firstWhere((element) => element.id == index - 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;
      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    _selectedRadio = radios[0];
    _selectedColor = Color(int.tryParse(_selectedRadio.color));
    print(radios);
    setState(() {});
  }

  _playMusic(String url) {
    _audioPlayer.play(url);
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    print(_selectedRadio.name);
    isPlayingRadio = _selectedRadio;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       VxAnimatedBox()
      //           .size(context.screenWidth, context.screenHeight * 0.08)
      //           .withGradient(
      //         LinearGradient(
      //           colors: [
      //             AIColors.primaryColor2,
      //             _selectedColor ?? AIColors.primaryColor1,
      //           ],
      //           begin: Alignment.bottomCenter,
      //           end: Alignment.topCenter,
      //         ),
      //       ).make(),
      //
      //     ],
      //   ),
      // ),
      drawer: Drawer(
        // 左边功能栏
        child: Container(
          color: _selectedColor ?? AIColors.primaryColor2,
          child: radios != null
              ? [
                  100.heightBox,
                  "All Channels".text.xl.white.semiBold.make().px16(),
                  20.heightBox,
                  ListView(
                    padding: Vx.m0,
                    shrinkWrap: true,
                    children: radios
                        .map((e) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(e.icon),
                              ),
                              title: "${e.name} FM".text.white.make(),
                              subtitle:
                                  e.tagline.text.white.make(), // CircleAvatar
                            ))
                        .toList(),
                  ).expand(),
                ].vStack(crossAlignment: CrossAxisAlignment.start)
              : const Offstage(),
        ),
      ),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(
                  colors: [
                    AIColors.primaryColor2,
                    _selectedColor ?? AIColors.primaryColor1,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
              .make(),
          [
            AppBar(
              title: "MZ Radio".text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ).h(100.0).p16(),
            // 上方漂浮语音提示块
            "Start with - Hey Alan 👇".text.italic.semiBold.white.make(),
            10.heightBox,
            VxSwiper.builder(
              itemCount: sugg.length,
              height: 50.0,
              viewportFraction: 0.35,
              autoPlay: true,
              autoPlayAnimationDuration: 3.seconds,
              autoPlayCurve: Curves.linear,
              enableInfiniteScroll: true,
              itemBuilder: (context, index) {
                final s = sugg[index];
                return Chip(
                  label: s.text.make(),
                  backgroundColor: Vx.randomColor,
                );
              },
            )
          ].vStack(alignment: MainAxisAlignment.start),
          30.heightBox,
          radios != null
              ? VxSwiper.builder(
                  itemCount: radios.length,
                  // 解决web自适应，即随页面自适应
                  aspectRatio: context.mdWindowSize == MobileWindowSize.xsmall
                      ? 1.0
                      : context.mdWindowSize == MobileWindowSize.medium
                          ? 2.0
                          : 3.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index) {
                    _selectedRadio = radios[index];
                    final colorHex = radios[index].color;
                    _selectedColor = Color(int.tryParse(colorHex));
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    final rad = radios[index];
                    return VxBox(
                            child: ZStack(
                      [
                        Positioned(
                          top: 0.0, // 类型标签
                          right: 0.0,
                          child: VxBox(
                                  child: rad.category.text.uppercase.white
                                      .make()
                                      .px16())
                              .height(40)
                              .black
                              .alignCenter
                              .withRounded(value: 10.0)
                              .make(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VStack(
                            [
                              rad.name.text.xl3.white.bold.make(),
                              5.heightBox, // 数字
                              rad.tagline.text.sm.white.semiBold.make(),
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: [
                              Icon(
                                CupertinoIcons.play_circle,
                                color: Colors.white,
                              ),
                              10.heightBox,
                              "Double tap to play".text.gray300.make(),
                            ].vStack())
                      ],
                    ))
                        .clip(Clip.antiAlias)
                        .bgImage(
                          DecorationImage(
                              image: NetworkImage(rad.image),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken)),
                        )
                        .border(color: Colors.black, width: 5.0) // 边框厚度
                        .withRounded(value: 60.0) // 歌曲窗口弧度
                        .make()
                        // 双击播放音乐
                        .onInkDoubleTap(() {
                      _playMusic(rad.url);
                    }).p16();
                  },
                ).centered()
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
          Align(
            alignment: Alignment(0.0, 0.9),
            child: [
              if (_isPlaying)
                "Playing Now = ${isPlayingRadio.name} FM"
                    .text
                    .white
                    .makeCentered(),
              Icon(
                _isPlaying
                    ? CupertinoIcons.stop_circle
                    : CupertinoIcons.play_circle,
                color: Colors.black87,
                size: 50.0,
              ).onInkTap(() {
                // 下方按钮播放音乐
                if (_isPlaying) {
                  _audioPlayer.release();
                } else {
                  _playMusic(_selectedRadio.url);
                }
              })
            ].vStack(),
          ).pOnly(bottom: context.percentHeight * 12),
          Align(
            alignment: Alignment(-0.5, 1.0),
            child: [
              IconButton(
                icon: Icon(Icons.home),
                color: Colors.white38,
                iconSize: 30.0,
                onPressed: (){},
              ),
              Text(
                "home",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11.0,
                ),
              )
            ].vStack(),
          ).pOnly(bottom: context.percentHeight * 2),
          Align(
            alignment: Alignment(0.5, 1.0),
            child: [
              IconButton(
                icon: Icon(Icons.mood),
                color: Colors.white,
                highlightColor: Colors.white38,
                splashColor: Colors.black87,
                iconSize: 30,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return new MyPage();
                  }));
                },
              ),
              Text(
                "my",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                ),
              )
            ].vStack(),
          ).pOnly(bottom: context.percentHeight * 2),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
