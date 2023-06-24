// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_field
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class user extends StatefulWidget {
  const user({Key? key}) : super(key: key);

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  late List<dynamic> newsList = [];

  Future<void> apicall() async {
    final response = await http.post(
      Uri.parse(
          'http://devapi.hidoc.co:8080/HidocWebApp/api/getArticlesByUid?sId=500&uuId=&userId=423914'),
    );
    if (response.statusCode == 200) {
      setState(() {
        final responseData = json.decode(response.body);
        newsList = responseData.containsKey('data')
            ? responseData['data']['trandingBulletin']
            : [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Need to give route
          },
          icon: Icon(
            Icons.house_siding_outlined,
            color: Colors.black,
            size: 40,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "HiDoc App",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        scrolledUnderElevation: 20,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -350,
            left: -250,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/bg.png', // Replace with your image path
                fit: BoxFit.contain,
                opacity: const AlwaysStoppedAnimation(0.5),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 150,
                  ),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Tranding Bulletin",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final newsItem = newsList[index];
                    final articleImg = newsItem['articleImg'] ?? '';
                    return Column(
                      children: [
                        Container(
                          height: 350,
                          width: 350,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                newsItem['articleTitle'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                newsItem['articleDescription'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
