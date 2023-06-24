import 'package:doctors_app/ArticleDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  late List<dynamic> newsList = [];
  late bool isLoading = false;

  Future<void> apicall() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(
          'http://devapi.hidoc.co:8080/HidocWebApp/api/getArticlesByUid?sId=500&uuId=&userId=423914'),
    );

    setState(() {
      isLoading = false;
    });

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

  Future<void> _refreshData() async {
    await apicall();
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
            left: -200,
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
          RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                      child: const Text(
                        "Trending Bulletin",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: newsList.length,
                          itemBuilder: (context, index) {
                            final newsItem = newsList[index];
                            final articleImg = newsItem['articleImg'] ?? '';
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleDetailsPage(
                                        articleData: newsItem),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 350,
                                    width: 350,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            articleImg), // Provide the image URL here
                                        fit: BoxFit.cover,
                                        opacity: 0.5,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          newsItem['articleDescription']
                                              .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
