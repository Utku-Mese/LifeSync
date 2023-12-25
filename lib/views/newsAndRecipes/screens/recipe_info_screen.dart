import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_sync/models/recipe_model.dart';
import 'package:life_sync/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';

class RecipeInfoScreen extends StatelessWidget {
  const RecipeInfoScreen({super.key, required this.recipe});

  final Recipe recipe;

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
              onPressed: () {
                share(
                    recipe.title ?? 'Title',
                    'Tarifin devami icin linki inceleyiniz:',
                    recipe.source ?? 'Source');
              },
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child: Image.network(
                  recipe.thumbnail ??
                      'https://i.nefisyemektarifleri.com/2023/11/11/unsuz-elmali-yulaf-kurabiye.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    recipe.title ?? 'Title',
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.all(6),
              child: ListView(
                children: [
                  Text(
                    recipe.contents ?? 'Description',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 1),
                  Text(
                    'Malzemeler',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.recipe ?? 'Ingredients',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.nearlyDarkBlue,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (!await launchUrl(Uri.parse(recipe.source!))) {
                        throw Exception('Could not launch ${recipe.source}');
                      }
                    },
                    child: Text(
                      'Devamı için tıklayınız',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
