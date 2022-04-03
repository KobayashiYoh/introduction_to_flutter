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
      home: const TwitterHomePage(),
    );
  }
}

class TwitterHomePage extends StatefulWidget {
  const TwitterHomePage({Key? key}) : super(key: key);

  @override
  State<TwitterHomePage> createState() => _TwitterHomePageState();
}

class _TwitterHomePageState extends State<TwitterHomePage> {
  String countFormatter(int count) {
    String countText = '';
    if (count >= 10000) {
      countText = '${(count / 10000).toStringAsFixed(1)}万';
    } else if (count > 0) {
      countText = count.toString();
    }
    return countText;
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
      title: SizedBox(
        width: 44.0,
        height: 44.0,
        child: Image.network(centerImageUrl),
      ),
      actions: <Widget>[
        Image.network(rightImageUrl),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
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
                color: Colors.black87,
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
      child: Text(
        tweet.text,
        style: const TextStyle(fontSize: 12.0),
      ),
    );
  }

  Widget tweetFooterItem(IconData iconData, int count) {
    String countText = countFormatter(count);
    return Expanded(
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black87,
            size: 16.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                countText,
                style: const TextStyle(color: Colors.black87, fontSize: 12.0),
              ),
            ),
          ),
        ], // <Widget>[]
      ), // Row
    );
  }

  Widget tweetFooter() {
    var rand = math.Random();
    int replayCount = rand.nextInt(500);
    int retweetCount = rand.nextInt(10000) + replayCount;
    int likesCount = rand.nextInt(90000) + retweetCount;
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

  Widget tweetItem({
    required Widget tweetImage,
    required Widget tweetHeader,
    required Widget tweetBody,
    required Widget tweetFooter,
  }) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

  Widget twitterBody({
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return ListView.builder(
      itemCount: Data.tweetList.length,
      shrinkWrap: true,
      itemBuilder: itemBuilder, // Column
    );
  }

  Widget twitterFloatingActionButton({required Icon icon}) {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 0,
      child: icon,
    );
  }

  Widget twitterBottomNavigationBar({
    required Color backgroundColor,
    required Icon homeIcon,
    required Icon searchIcon,
    required Icon bellIcon,
    required Icon mailIcon,
  }) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black45,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 28.0,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: homeIcon,
          label: '',
        ),
        BottomNavigationBarItem(
          icon: searchIcon,
          label: '',
        ),
        BottomNavigationBarItem(
          icon: bellIcon,
          label: '',
        ),
        BottomNavigationBarItem(
          icon: mailIcon,
          label: '',
        ),
      ],
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
        icon: const Icon(
          CupertinoIcons.add,
          size: 32.0,
        ),
      ), // floatingActionButton

      // ----------------------- bottomNavigationBar -----------------------
      bottomNavigationBar: twitterBottomNavigationBar(
        backgroundColor: Colors.white,
        homeIcon: const Icon(CupertinoIcons.home),
        searchIcon: const Icon(CupertinoIcons.search),
        bellIcon: const Icon(CupertinoIcons.bell),
        mailIcon: const Icon(CupertinoIcons.mail),
      ), // bottomNavigation
    ); // Scaffold
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
