import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/main.dart';
import 'package:porter_app/src/UI/home.dart';
import 'package:porter_app/src/UI/porter_tasks.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

import '../data/porter.dart';
import '../repo/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late int _selectedIndex;
  late PageController _pageController;
  late Porter arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController();
    Future.microtask(() async {
      Pushy.listen();
      Pushy.setNotificationListener(backgroundNotificationListener);
      final pushy = await ref.watch(pushyRef.future);
      pushy.sendToTaskScreen(context, arguments);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    arguments = ModalRoute.of(context)?.settings.arguments as Porter;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      TaskDataScreen(arguments),
      const PorterTasks(),
      // TaskScreen(client),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Porter App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavyBar(
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home), title: const Text('Home')),
            BottomNavyBarItem(
                icon: const Icon(Icons.person), title: const Text('Profile')),
          ],
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.jumpToPage(index);
            });
          }),
    );
  }
}
