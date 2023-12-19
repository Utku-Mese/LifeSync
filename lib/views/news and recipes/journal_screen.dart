import 'package:flutter/material.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'package:life_sync/views/news%20and%20recipes/screens/news_screen.dart';
import 'package:life_sync/views/news%20and%20recipes/screens/recipes_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final List<Widget> _pages = const <Widget>[
    NewsScreen(),
    RecipesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppTheme.background,
          appBar: const TabBar(
            indicatorColor: AppTheme.nearlyDarkBlue,
            labelColor: AppTheme.nearlyDarkBlue,
            unselectedLabelColor: AppTheme.nearlyBlack,
            tabs: <Widget>[
              Tab(
                text: 'Bülten',
              ),
              Tab(
                text: 'Tarifler',
              ),
            ],
          ),
          body: TabBarView(children: _pages),
        ),
      ),
    );
  }
}
