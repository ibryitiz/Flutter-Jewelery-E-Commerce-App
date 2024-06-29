class CategoriesModel{
  dynamic id;
  String name;

  CategoriesModel({
    this.id,
    required this.name,
});

  factory CategoriesModel.fromMap(Map<String , dynamic> map , {dynamic key}){
    return CategoriesModel( id: key ?? map["id"], name: map["name"]);
  }

  Map<String, dynamic> toMap({dynamic key}){
    return {
      "id" : key ?? id,
      "name" : name,
    };
  }
}