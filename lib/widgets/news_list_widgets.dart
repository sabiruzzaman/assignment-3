import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';

class NewsListWidgets extends StatelessWidget {
  final double heigth;
  final double width;
  final double padding;

  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const NewsListWidgets(
      {Key? key,
      required this.heigth,
      required this.width,
      required this.padding,
      required this.title,
      required this.description,
      required this.author,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateObj = DateTime.parse(publishedAt);
    String articleDate = formatDate(dateObj, [M, ' ', d]);
    return Card(
        child: Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 120,
            height: 100,
            padding: const EdgeInsets.all(7.0),
            child: Hero(
              tag: title,
              child: ClipRRect(
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) =>
                      Image.asset('assets/images/placeholder.png'),
                  imageUrl: urlToImage,
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/placeholder.png'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  title ?? " ",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        author ?? " ",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        articleDate ?? " ",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    ));
  }
}
