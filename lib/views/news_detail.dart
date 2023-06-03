import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prac_tpm_final_project_2/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatefulWidget {
  NewsModel newsModel;
  NewsDetailPage({
    Key? key,
    required this.newsModel,
  }) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late String date;

  @override
  void initState() {
    super.initState();
    date = widget.newsModel.publishedAt!;
  }

  String changeDate(String date) {
    String newDate = date.substring(0, 10) + ' ' + date.substring(11, 19);
    return newDate;
  }

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse(widget.newsModel.url);
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.newsModel.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              DateFormat("EEEE, d MMMM y")
                  .format(DateTime.parse(changeDate(date))),
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 15),
            Image(image: NetworkImage(widget.newsModel.urlToImage!)),
            SizedBox(height: 15),
            Text('Author : ' + widget.newsModel.author!),
            SizedBox(height: 15),
            Text(widget.newsModel.description!),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () async {
                if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
                  throw 'Could not launch $_url';
                }
              },
              child: Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
