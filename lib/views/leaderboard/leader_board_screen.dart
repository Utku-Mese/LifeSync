import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_sync/utils/app_theme.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.nearlyDarkBlue,
        iconTheme: const IconThemeData(color: AppTheme.nearlyWhite),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32),
          ),
        ),
        title: const Text(
          'Lider Tablosu',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 22 + 6 - 6,
            letterSpacing: 1.2,
            color: AppTheme.nearlyWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var users = snapshot.data!.docs;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var userData = users[index].data() as Map<String, dynamic>;
                  var username = userData['username'];
                  var photoUrl = userData['profilePhoto'];
                  var place = index + 1;

                  return ListTile(
                    leading: place == 1
                        ? const Text('🥇', style: TextStyle(fontSize: 20))
                        : place == 2
                            ? const Text('🥈', style: TextStyle(fontSize: 20))
                            : place == 3
                                ? const Text('🥉',
                                    style: TextStyle(fontSize: 20))
                                : Padding(
                                    padding: const EdgeInsets.only(left: 7.0),
                                    child: Text('$place',
                                        style: const TextStyle(fontSize: 20)),
                                  ),
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(photoUrl),
                        ),
                        const SizedBox(width: 18),
                        Text(username),
                      ],
                    ),
                    trailing: const Text(
                      '0 🏆',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
