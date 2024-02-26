import 'package:flutter/material.dart';
import 'package:study_language_ai_flutter_project/lang_card/view/card_screen.dart';
import 'package:study_language_ai_flutter_project/search/view/search_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:study_language_ai_flutter_project/user/view/user_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;


  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.animation!.addListener(_handleTabAnimation);
  }

  void _handleTabAnimation() {
    // Check if the transition between tabs is completed

    final newIndex = _controller.animation!.value.round();

    if (newIndex != currentIndex) {
      setState(() {
        currentIndex = newIndex;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.animation!.removeListener(_handleTabAnimation);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white.withOpacity(0),
      //   title: DefaultTextStyle(
      //     style: const TextStyle(
      //       fontSize: 20.0,
      //     ),
      //     child: AnimatedTextKit(
      //       animatedTexts: [
      //         WavyAnimatedText('Soul Message'),
      //       ],
      //       isRepeatingAnimation: true,
      //       totalRepeatCount: 1,
      //       onTap: () {
      //         print("Tap Event");
      //       },
      //     ),
      //   ),
      // ),
      body: tabView(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: currentIndex,
        selectedIconTheme: IconThemeData(
            color: Colors.black, size: MediaQuery.of(context).size.width / 10),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage_sharp),
            label: 'CARD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.saved_search),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outlined),
            label: 'INFO',
          ),
        ],
      ),
    );
  }

  void _onTap(index) {
    setState(() {
      currentIndex = index;
      _controller.index = index;
    });
  }

  Widget tabView() {
    return TabBarView(
      controller: _controller,
      children: [
        CardScreen(),
        SearchScreen(),
        UserInfoScreen(),
      ],
    );
  }
}
