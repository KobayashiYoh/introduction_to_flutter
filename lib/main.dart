import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction to Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: const BottomNavigation(),
    ); // MaterialApp
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.black87,
        inactiveColor: Colors.black45,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), // ホームアイコン
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search), // 検索アイコン
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell), // 通知アイコン
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.mail), // DMアイコン
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const Page1());
          case 1:
            return CupertinoTabView(builder: (context) => const Page2());
          case 2:
            return CupertinoTabView(builder: (context) => const Page3());
          case 3:
            return CupertinoTabView(builder: (context) => const Page4());
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Widget tweetHeader(Tweet tweet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Row(
            children: [
              Text(
                tweet.userName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ), // TextStyle
              ), // Text
              const SizedBox(width: 8.0),
              Text('@${tweet.userId}'),
              const Text('・1時間'),
            ],
          ),
        ),
        const Icon(
          Icons.keyboard_control,
          size: 20.0,
          color: Colors.grey,
        ), // Icon
      ], // <Widget>[]
    ); // Row
  }

  Widget tweetBody(Tweet tweet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Text(tweet.text),
    );
  }

  Widget tweetFooter() {
    var rand = math.Random();
    int replayCount = rand.nextInt(1000);
    int retweetCount = rand.nextInt(10000) + replayCount;
    int likesCount = rand.nextInt(1000000) + retweetCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        tweetFooterItem(
          CupertinoIcons.chat_bubble, // 返信
          replayCount,
        ),
        tweetFooterItem(
          CupertinoIcons.arrow_2_squarepath, // リツイート
          retweetCount,
        ),
        tweetFooterItem(
          CupertinoIcons.heart, // いいね
          likesCount,
        ),
        tweetFooterItem(
          CupertinoIcons.tray_arrow_up, // 共有
          0,
        ),
      ], // <Widget>[]
    ); // Row
  } // sparkles

  Widget tweetFooterItem(IconData iconData, int count) {
    String countText = '';
    if (count >= 10000) {
      countText = '${count / 10000}万';
    } else if (count > 0) {
      countText = count.toString();
    }

    return Expanded(
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.grey,
            size: 20.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                countText,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ], // <Widget>[]
      ),
    ); // Row
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(Data.loginUser.iconUrl), // AppBar左の画像
          ),
        ),
        title: Image.network(
          'https://img.icons8.com/color/48/000000/twitter--v1.png', // AppBar中央の画像
        ),
        actions: <Widget>[
          Image.network(
            'https://img.icons8.com/material-outlined/24/000000/sparkling.png', // AppBar右の画像
          ),
        ],
        foregroundColor: Colors.black87, // AppBarのアイコンの色
        backgroundColor: Colors.white, // AppBarの背景色
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ), // AppBar,
      body: SafeArea(
        child: ListView.builder(
          itemCount: Data.tweetList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 24.0,
                      backgroundImage:
                          NetworkImage(Data.tweetList[index].userIconUrl),
                    ), // CircleAvatar
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          tweetHeader(Data.tweetList[index]),
                          tweetBody(Data.tweetList[index]),
                          tweetFooter(),
                        ], // <Widget>[]
                      ), // Column
                    ), // Flexible
                  ], // <Widget>[]
                ), // Row
              ), // Container
              const Divider(),
            ], // <Widget>[]
          ), // Column
        ),
      ), // ListView.builder
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 48.0),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          child: const Icon(
            Icons.add, // 画面右下の青いボタン
            size: 32.0,
          ),
        ),
      ), // FloatingActionButton
    ); // Scaffold
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class User {
  String iconUrl;
  String name;
  String id;

  User({
    required this.iconUrl,
    required this.name,
    required this.id,
  });
}

class Tweet {
  String userIconUrl;
  String userName;
  String userId;
  String text;
  String postImage;

  Tweet({
    required this.userIconUrl,
    required this.userName,
    required this.userId,
    required this.text,
    required this.postImage,
  });
}

class Data {
  // ---------------------- ログインユーザーのデータ ---------------------
  static User loginUser = User(
    iconUrl:
        'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
    name: 'name',
    id: 'id',
  );

  // ------------------------- ツイートのデータ -------------------------
  static List<Tweet> tweetList = [
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'nameeeee',
      userId: 'idddddddd',
      text: 'こんにちは\nはじめまして\nうっひょー',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
    ),
  ];
}
