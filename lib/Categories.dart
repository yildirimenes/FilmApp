class Categories{
  String category_id;
  String category_name;

  Categories(this.category_id, this.category_name);

  factory Categories.fromJson(String key,Map<dynamic,dynamic> json){
    return Categories(key,json["category_name"] as String);
  }
}