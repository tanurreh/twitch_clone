import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitch_clone/app/data/constants.dart';
import 'package:twitch_clone/app/modules/home/controllers/live_stream_controller.dart';
import 'package:twitch_clone/app/modules/home/controllers/user_controller.dart';
import 'package:twitch_clone/app/modules/home/views/feed_screen.dart';
import 'package:twitch_clone/app/modules/home/views/go_live_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   UserController userController = Get.put(UserController());
  final LiveSteamController _liveStreamController =
      Get.put(LiveSteamController());
  int _page = 0;
  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    const Center(
      child: Text('Browser'),
    ),
  ];

  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CustomColor.buttonColor,
        unselectedItemColor: CustomColor.primaryColor,
        backgroundColor: CustomColor.backgroundColor,
        unselectedFontSize: 12,
        onTap: onPageChange,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_rounded,
            ),
            label: 'Go Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.copy,
            ),
            label: 'Browse',
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}