import 'package:flutter/material.dart';
import 'package:prac_tpm_final_project_2/service/base_network.dart';
import 'package:prac_tpm_final_project_2/views/news_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15.3),
            border: InputBorder.none,
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Search News Here",
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                setState(() {
                  query = '';
                });
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
          onEditingComplete: () {
            setState(() {
              query = searchController.text;
            });
          },
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: query != ""
          ? FutureBuilder(
              future: BaseNetwork().getNewsSearch(query),
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
                                    width: 225,
                                    height: 115,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: snapshot.data.length,
                    ),
                  );
                }
              },
            )
          : const Center(
              child: Text('Empty'),
            ),
    );
  }
}
