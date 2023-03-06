import 'package:flutter/material.dart';
import 'package:film_app/Categories.dart';
import 'package:film_app/films_page.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  var refCategories = FirebaseDatabase.instance.ref().child("categories");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kategoriler"),
        ),
        body: StreamBuilder<DatabaseEvent>(
          stream: refCategories.onValue,
          builder: (context,event){
            if(event.hasData){
              var categoryList = <Categories>[];

              var getValue = event.data!.snapshot.value as dynamic;

              if(getValue != null){
                getValue.forEach((key,obj){
                  var getCategory = Categories.fromJson(key,obj);
                  categoryList.add(getCategory);
                });
              }

              return ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (context,index){
                    var category = categoryList[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FilmsPage(category: category)));
                      },
                      child: Card(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(category.category_name),
                            ],
                          ),
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
        )
    );
  }
}
