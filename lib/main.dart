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
  int _selectIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
  ]; // <Widget>[]

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.rectangle), // AppBar左のアイコン
        title: const Icon(Icons.rectangle), // AppBar中央のアイコン
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.rectangle), // AppBar右のアイコン
          ), // Container
        ], // <Widget>[]
        foregroundColor: Colors.white, // AppBarのアイコンの色
        backgroundColor: Colors.blue, // AppBarの背景色
        centerTitle: true,
      ), // AppBar
      body: _widgetOptions.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          // ----- Page1 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page1',
          ), //BottomNavigationBarItem
          // ----- Page2 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page2',
          ), //BottomNavigationBarItem
          // ----- Page3 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page3',
          ), //BottomNavigationBarItem
          // ----- Page4 -----
          BottomNavigationBarItem(
            icon: Icon(Icons.rectangle),
            label: 'Page4',
          ), //BottomNavigationBarItem
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ), // BottomNavigation
    ); // Scaffold
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

  Widget tweetFooter(Tweet tweet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        tweetFooterItem(Icons.chat_bubble_outline, tweet.replayCount), // リプライ
        tweetFooterItem(Icons.repeat, tweet.retweetCount), // リツイート
        tweetFooterItem(Icons.favorite_border, tweet.likesCount), // いいね
        tweetFooterItem(Icons.upload_outlined, -1), // 共有
      ], // <Widget>[]
    ); // Row
  }

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
      body: ListView.builder(
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
                        tweetFooter(Data.tweetList[index]),
                      ], // <Widget>[]
                    ), // Column
                  ), // Flexible
                ], // <Widget>[]
              ), // Row
            ), // Container
            const Divider(),
          ], // <Widget>[]
        ), // Column
      ), // ListView.builder
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: const Icon(
          Icons.add,
          size: 32.0,
        ), // Icon
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

class Tweet {
  String userIconUrl;
  String userName;
  String userId;
  String text;
  String postImage;
  int replayCount;
  int retweetCount;
  int likesCount;

  Tweet({
    required this.userIconUrl,
    required this.userName,
    required this.userId,
    required this.text,
    required this.postImage,
    required this.replayCount,
    required this.retweetCount,
    required this.likesCount,
  });
}

class Data {
  // ------------------------- ツイートのデータ -------------------------
  static List<Tweet> tweetList = [
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'nameeeee',
      userId: 'idddddddd',
      text: 'こんにちは\nはじめまして\nうっひょー',
      postImage: '',
      replayCount: 12,
      retweetCount: 3,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 1000000,
      retweetCount: 100000,
      likesCount: 10000,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 1000,
      retweetCount: 100,
      likesCount: 10,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
    Tweet(
      userIconUrl:
          'https://pbs.twimg.com/media/FPTPnEvVQAQ6C9z?format=jpg&name=360x360',
      userName: 'name',
      userId: 'id',
      text: '投稿文',
      postImage: '',
      replayCount: 0,
      retweetCount: 0,
      likesCount: 0,
    ),
  ]; // ------------------------- ツイートのデータ -------------------------

}
