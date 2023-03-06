class Films {
  String film_id;
  String film_name;
  int film_date;
  String film_image;
  String category_name;
  String director_name;


  Films(this.film_id, this.film_name, this.film_date, this.film_image,
      this.category_name, this.director_name);

  factory Films.fromJson(String key,Map<dynamic,dynamic> json) {
    return Films(key
        , json["film_name"] as String
        , json["film_date"] as int
        , json["film_image"] as String
        , json["category_name"] as String
        , json["director_name"] as String);
  }
}
