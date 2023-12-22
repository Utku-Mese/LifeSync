import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_sync/models/news_model.dart';
import 'package:life_sync/utils/app_theme.dart';

class NewsInfoScreen extends StatelessWidget {
  const NewsInfoScreen({super.key, required this.news});

  final News news;

  /* final News news = News(     deneme verisi
    title: 'Title',
    datetime: 'Date',
    thumpnail:
        'https://image.cnnturk.com/i/cnnturk/75/0x555/64f70c6da4686007ec300eec.jpg',
  ); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppTheme.white,
          size: 30,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppTheme.white.withOpacity(0.25),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Icon(Icons.share),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppTheme.background,
          ),
          Image.network(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            news.thumpnail ??
                'https://image.cnnturk.com/i/cnnturk/75/0x555/64f70c6da4686007ec300eec.jpg',
            fit: BoxFit.cover,
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppTheme.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.2, 0.4],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4 - 32,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        news.title ?? 'Title',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  news.datetime ?? 'Date',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  news.contents ?? 'Description',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
