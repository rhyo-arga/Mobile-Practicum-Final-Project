import 'package:flutter/material.dart';
import 'package:prac_tpm_final_project_2/service/base_network.dart';
import 'package:prac_tpm_final_project_2/views/news_detail.dart';
import 'package:prac_tpm_final_project_2/views/profilepage.dart';
import 'package:prac_tpm_final_project_2/views/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Home_Page(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(29, 66, 137, 1),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: BaseNetwork().getNewsUS(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(''),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Image.network(
                              snapshot.data[index].urlToImage,
                              width: 160,
                              height: 110,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 225,
                                height: 115,
                                child: const Icon(
                                  Icons.error,
                                  size: 100,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 7, right: 7, top: 10),
                                  child: Text(
                                    snapshot.data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )))
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailPage(
                              newsModel: snapshot.data[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: snapshot.data.length,
              ),
            );
          }
        },
      ),
    );
  }
}
