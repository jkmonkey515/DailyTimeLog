class CategoryModel{
  int category_id =-1;
  String category_name = "";
  int is_default=0;
  int is_active=1;
  String created_at="";
  String updated_at="";

  CategoryModel({
    required this.category_id ,
    required this.category_name ,
    required this.is_default ,
    required this.is_active ,
    required this.created_at ,
    required this.updated_at ,
  });

}