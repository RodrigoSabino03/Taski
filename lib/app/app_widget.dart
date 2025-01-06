import 'package:flutter/material.dart';
import 'package:todolist/app/home/home_page.dart';
import 'package:todolist/app/search/search_page.dart';
import 'package:todolist/app/done/done_page.dart';
import 'package:todolist/app/ui/widgets/appbar_widget.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const DonePage(),
  ];

  var selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: _pages[selectedIndex], 
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.list), label: 'Todo'),
            NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.check), label: 'Done'),
          ],
        ),
      ),
    );
  }
}
