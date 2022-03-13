// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isDarkMode = false;
  Map data = {};
  final defColor = Color.fromRGBO(38, 35, 92, 1);
  final defColor2 = Color.fromRGBO(107, 96, 185, 1);

  void toggleMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void fetchData() async {
    final response = await http.get(Uri.parse("https://script.googleusercontent.com/macros/echo?user_content_key=xb7gYdo8sSb4hsV835Fp-iZNZz3YlMjZ0eL_GczYMNBND6jcgMVlOxhTMAYDWbQE1gc3duVuAiCcFY0ePE3MTU4CFf4Tbaaqm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnNsHSMmXq-k19dE_DvThJzPMEitbPb3SU5l_i-3w9HqS8Yk8yFriOPf-ulbe1QHFr7iVd_ROl7oFYnNXdHswZmeeGiwEmyZ7adz9Jw9Md8uu&lib=MCQ7-PCgFr0rDVI60wR8OAyqytt5QPohG"));
    Map d = json.decode(response.body);
    setState(() {
      data = d;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: data["name"] == null ? Container() : Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode ? defColor : Colors.white,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Image.asset('assets/Light Bulb.png', height: 20.0, width: 20.0, color: isDarkMode ? defColor2 : defColor,),
                onPressed: toggleMode,
              ),
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDarkMode ? defColor : Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 30.0,),
              Center(child: Image.asset('assets/Profile Picture.png', width: 150,)),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Text(
                    data["name"],
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 23,
                    ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),   
                child: Text(
                  data["position"],
                  style: TextStyle(
                    color: isDarkMode ? defColor2: defColor,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(35.0),
                child: Text(
                  data["description"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.4,
                    wordSpacing: 1.0,
                    color: isDarkMode ? Colors.white70 : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){launch('mailto:${data["email"]}');},
                  child: Text(data["email"]),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    primary: isDarkMode ? Colors.white70 : Colors.white,
                    textStyle: const TextStyle(fontSize: 12,),
                    backgroundColor: isDarkMode ? defColor2 : defColor,
                  ),
              ),
              const SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Image.asset('assets/Twitter.png', color: isDarkMode ? defColor2 : defColor,),
                      iconSize: 5,
                      onPressed: (){_launchURL(data["socials"]["twitter"]);},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Image.asset('assets/Instagram.png', color: isDarkMode ? defColor2 : defColor,),
                      iconSize: 5,
                      onPressed: (){_launchURL(data["socials"]["instagram"]);},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Image.asset('assets/Dribbble.png', color: isDarkMode ? defColor2 : defColor,),
                      iconSize: 5,
                      onPressed: (){_launchURL(data["socials"]["dribbble"]);},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Image.asset('assets/LinkedIn.png', color: isDarkMode ? defColor2 : defColor,),
                      iconSize: 5,
                      onPressed: (){_launchURL(data["socials"]["linkedin"]);},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Image.asset('assets/Github.png', color: isDarkMode ? defColor2 : defColor,),
                      iconSize: 5,
                      onPressed: (){_launchURL(data["socials"]["github"]);},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Image.asset('assets/Dev.png', color: isDarkMode ? defColor2 : defColor,),
                      iconSize: 5,
                      onPressed: (){_launchURL(data["socials"]["devCommunity"]);},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
