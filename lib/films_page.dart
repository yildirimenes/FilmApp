import 'package:film_app/Categories.dart';
import 'package:film_app/Films.dart';
import 'package:film_app/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class FilmsPage extends StatefulWidget {

  Categories category;
  FilmsPage({required this.category});

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {

  var refFilms = FirebaseDatabase.instance.ref().child("films");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler : ${widget.category.category_name}"),
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: refFilms.orderByChild("category_name").equalTo(widget.category.category_name).onValue,
        builder: (context,event){
          if(event.hasData){
            var filmsList = <Films>[];

            var getValue = event.data!.snapshot.value as dynamic;

            if(getValue != null){
              getValue.forEach((key,obj){
                var getFilm = Films.fromJson(key, obj);
                filmsList.add(getFilm);
              });
            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.5,
                ),
                itemCount: filmsList.length,
                itemBuilder: (context,index){
                  var film = filmsList[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(films: film,)));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("images/${film.film_image}"),
                          ),
                          Text(film.film_name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          else{
            return Center();
          }
        },
      ),

    );
  }
}
