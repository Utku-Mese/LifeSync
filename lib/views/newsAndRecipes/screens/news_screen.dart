import 'package:flutter/material.dart';
import 'package:life_sync/models/news_model.dart';
import 'package:life_sync/views/newsAndRecipes/screens/news_info_screen.dart';
import 'package:life_sync/views/newsAndRecipes/widgets/card_loading_widget.dart';
import 'package:life_sync/views/newsAndRecipes/widgets/news_card_widget.dart';

import '../../../controller/news_controller.dart';
import '../../diary/widgets/foodList/my_search_bar_view.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsController _newsController = NewsController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySearchBar(),
        Expanded(
          child: FutureBuilder<List<News>>(
            future: _newsController.fetchNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const LoadingCard();
                  },
                  padding: const EdgeInsets.only(bottom: 85.0),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Could not retrieve data: ${snapshot.error}'),
                );
              } else {
                final news = snapshot.data;
                return ListView.builder(
                  itemCount: news?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsInfoScreen(news: news![index]),
                          ),
                        );
                      },
                      child: NewsCard(news: news, index: index),
                    );
                  },
                  padding: const EdgeInsets.only(bottom: 85.0),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
