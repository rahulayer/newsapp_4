import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp_4/helper/data.dart';
import 'package:newsapp_4/helper/news.dart';
import 'package:newsapp_4/models/category_model.dart';
import 'package:newsapp_4/models/article_model.dart';
import 'package:newsapp_4/views/article_view.dart';
import 'package:newsapp_4/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
   getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.article, // Replace with the desired icon
              color: Colors.blue, // Adjust icon color as needed
            ),
            SizedBox(width: 5), // Add some spacing between icon and text
            Text(
              "NEWS ",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "24",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget> [
              ///Categories
              Container(
                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){

                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),
        
              ///Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                    return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                    url: articles[index].url,);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({super.key, required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
       Navigator.push(context, MaterialPageRoute(
           builder: (context) => CategoryNews(
               category: categoryName.toLowerCase(),
           )
       ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
             ClipRRect(

               borderRadius: BorderRadius.circular(6),
                 child: CachedNetworkImage(imageUrl: imageUrl, width: 120, height: 60, fit:BoxFit.cover,)
             ),
      
          Container(
            alignment: Alignment.center,
            width: 120, height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color:const Color.fromRGBO(0, 0, 0,90)
            ),

            child: Text(categoryName, style: TextStyle(
              color: Colors.white, fontSize: 14,
              fontWeight: FontWeight.w500
      
            ),),
          )],
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl, required this.title, required this.desc,
  required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
            blogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget> [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
                fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(
              color: Colors.black54
            ),)
            
          ],
      
        ),
      
      ),
    );
  }
}
