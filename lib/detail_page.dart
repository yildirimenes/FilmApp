import 'package:film_app/Films.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  
  Films films;
  DetailPage({required this.films});
  
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.films.film_name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("images/${widget.films.film_image}"),
            Text(widget.films.film_date.toString(),style: TextStyle(fontSize: 30),),
            Text(widget.films.director_name,style: TextStyle(fontSize: 30),),

          ],
        ),
      ),
    );
  }
}
