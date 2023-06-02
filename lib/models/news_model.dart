
class NewsModel {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? '-',
        title: json["title"] ?? '-',
        description: json["description"] ?? '-',
        url: json["url"] ?? '-',
        urlToImage: json["urlToImage"] ??
            'https://btklsby.go.id/images/placeholder/basic.png',
        publishedAt: json["publishedAt"] ?? '-',
        content: json["content"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };
}

class Source {
  String? id;
  String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"] ?? '-',
        name: json["name"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}