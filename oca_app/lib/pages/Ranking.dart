import 'package:flutter/material.dart';
import 'package:oca_app/backend_funcs/social_func.dart';
import 'package:oca_app/components/User_instance.dart';
import 'package:oca_app/backend_funcs/peticiones_api.dart';
import 'dart:async';
import 'package:oca_app/components/logros_class.dart';
import 'package:oca_app/components/ranking_class.dart';

class RankingScreen extends StatefulWidget {
  RankingScreen({super.key});

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late Future<RankingResponse> futureRanking;

  @override
  void initState() {
    super.initState();
    futureRanking = getRanking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 100, 116),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Ranking",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.white,
                  child: FutureBuilder<RankingResponse>(
                    future: futureRanking,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.ranking.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  '${snapshot.data!.ranking[index].usuario} - ${snapshot.data!.ranking[index].vecesoca} veces en la oca'),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
