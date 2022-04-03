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
      ),
      home: const BottomNavigation(),
    );
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
        activeColor: Colors.black87, //  TabBar・選択アイコンの色
        inactiveColor: Colors.black45, // TabBar・非選択アイコンの色
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), // TabBar・ホームアイコン
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search), // TabBar・検索アイコン
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell), // TabBar・通知アイコン
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.mail), // TabBar・DMアイコン
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
  String countFormatter(int count) {
    String countText = '';
    if (count >= 10000) {
      countText = '${(count / 10000).toStringAsFixed(1)}万';
    } else if (count > 0) {
      countText = count.toString();
    }
    return countText;
  }

  Widget tweetImage(Tweet tweet) {
    return CircleAvatar(
      radius: 20.0,
      backgroundImage: NetworkImage(tweet.userIconUrl),
    );
  }

  Widget tweetHeader(Tweet tweet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
              children: [
                TextSpan(
                  text: tweet.userName,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(width: 8.0),
                ),
                TextSpan(
                  text: '@${tweet.userId}',
                ),
                const TextSpan(
                  text: '・',
                  style: TextStyle(fontSize: 10.0),
                ),
                const TextSpan(text: '1時間'),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Icon(
          Icons.keyboard_control,
          size: 16.0,
          color: Colors.grey,
        ),
      ], // <Widget>[]
    ); // Row
  }

  Widget tweetBody(Tweet tweet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Text(tweet.text),
    );
  }

  Widget tweetFooterItem(IconData iconData, int count) {
    String countText = countFormatter(count);
    return Expanded(
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black54,
            size: 20.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                countText,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ], // <Widget>[]
      ), // Row
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
          CupertinoIcons.chat_bubble,
          replayCount,
        ),
        tweetFooterItem(
          CupertinoIcons.arrow_2_squarepath,
          retweetCount,
        ),
        tweetFooterItem(
          CupertinoIcons.heart,
          likesCount,
        ),
        tweetFooterItem(
          CupertinoIcons.tray_arrow_up,
          0,
        ),
      ], // <Widget>[]
    ); // Row
  }

  PreferredSizeWidget twitterAppBar({
    required Color backgroundColor,
    required String lightImageUrl,
    required String centerImageUrl,
    required String rightImageUrl,
  }) {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(
          radius: 8.0,
          backgroundImage: NetworkImage(lightImageUrl),
        ),
      ),
      title: Image.network(centerImageUrl),
      actions: <Widget>[
        Image.network(rightImageUrl),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  Widget tweetItem({
    required Widget tweetImage,
    required Widget tweetHeader,
    required Widget tweetBody,
    required Widget tweetFooter,
  }) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              tweetImage,
              const SizedBox(width: 8.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    tweetHeader,
                    tweetBody,
                    tweetFooter,
                  ], // <Widget>[]
                ), // Column
              ),
            ], // <Widget>[]
          ), // Row
        ),
        const Divider(),
      ], // <Widget>[]
    );
  }

  Widget twitterBody(
      {required Widget Function(BuildContext, int) itemBuilder}) {
    return ListView.builder(
      itemCount: Data.tweetList.length,
      shrinkWrap: true,
      itemBuilder: itemBuilder, // Column
    );
  }

  Widget twitterFloatingActionButton({required IconData iconData}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 48.0),
      child: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: Icon(
          iconData,
          size: 32.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ------------------------------ appBar ------------------------------
      appBar: twitterAppBar(
        backgroundColor: Colors.white,
        lightImageUrl: Data.loginUser.iconUrl,
        centerImageUrl:
            'https://img.icons8.com/color/48/000000/twitter--v1.png',
        rightImageUrl:
            'https://img.icons8.com/material-outlined/24/000000/sparkling.png',
      ), // appBar

      // ------------------------------ body ------------------------------
      body: twitterBody(
        itemBuilder: (BuildContext context, int index) {
          Tweet tweet = Data.tweetList[index];
          return tweetItem(
            tweetImage: tweetImage(tweet),
            tweetHeader: tweetHeader(tweet),
            tweetBody: tweetBody(tweet),
            tweetFooter: tweetFooter(),
          );
        },
      ), // body

      // ----------------------- floatingActionButton -----------------------
      floatingActionButton: twitterFloatingActionButton(
        iconData: CupertinoIcons.add,
      ), // floatingActionButton
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
} // class User

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
} // class Tweet

class Data {
  // ---------------------- ログインユーザーのデータ ---------------------
  static User loginUser = User(
    iconUrl:
        'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
    name: 'name',
    id: 'id',
  ); // loginUser

  // ------------------------- ツイートのデータ -------------------------
  static List<Tweet> tweetList = [
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'nameeeeeeee',
      userId: 'idddddddddddddddddddddddddddddd',
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
  ]; // tweetList
} // class Data
