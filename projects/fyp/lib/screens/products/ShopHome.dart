import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/products/reports.dart';
import 'package:fyp/screens/products/sales.dart';
class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key, required this.shopId});
  final String shopId;
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
  List <String> imageUrls=[
    "https://firebasestorage.googleapis.com/v0/b/facebook-d0866.appspot.com/o/user_images%2FUser(displayName%3A%20%2C%20email%3A%20n%40gmail.com%2C%20isEmailVerified%3A%20false%2C%20isAnonymous%3A%20false%2C%20metadata%3A%20UserMetadata(creationTime%3A%202023-12-07%2004%3A13%3A37.064Z%2C%20lastSignInTime%3A%202024-01-07%2011%3A28%3A02.690Z)%2C%20phoneNumber%3A%20%2C%20photoURL%3A%20null%2C%20providerData%2C%20%5BUserInfo(displayName%3A%20%2C%20email%3A%20n%40gmail.com%2C%20phoneNumber%3A%20%2C%20photoURL%3A%20null%2C%20providerId%3A%20password%2C%20uid%3A%20n%40gmail.com)%5D%2C%20refreshToken%3A%20null%2C%20tenantId%3A%20null%2C%20uid%3A%205MGtBhDCCJTvVGEAhJx93Kw4K5I2).jpg?alt=media&token=fd989d5f-6014-42cd-9e9a-83f7e267bc3f"
  ];
    
    //   // appBar:AppBar(backgroundColor: Theme.of(context).colorScheme.onSecondary,),
    //   body:
     return   Container(
          width: 500,
          height:double.infinity,
           decoration: const  BoxDecoration(
          gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),
        // color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                        // padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                       color: const Color.fromARGB(100, 131, 107, 137), 
                      ),
                        child: const Row(children:[
                          Icon(Icons.search,
                          color: Colors.white,
                          ),
                          Text("Search Products...",
                          style: TextStyle(color: Colors.white),)
                        ])
                      ,),
                         CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: imageUrls.map((String url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                      //   width: double.infinity,
                      //   height: 200,
                        
                      //   decoration: BoxDecoration(
                      //     // color: ,
                      //     border: Border.all(color: Colors.black,
                          
                      //     width: 2.5),
                      //     borderRadius: BorderRadius.circular(12)
                      //   ),
                      //   child: Center(
                      //     child: Text("Image Carouel",style: TextStyle(
                      //       color: Colors.white
                      //     ),),
                      //   ),
                      // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder:(ctx) =>  SalesDashboard(shopId: shopId,) ));
                            },
                            child: Container(
                              width: 150,
                              height: 200,
                              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration:  BoxDecoration(
                                border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.deepPurple,
                                gradient:const  LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)])
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.stacked_bar_chart_sharp,
                                color: Colors.deepOrange,
                                size: 35,
                                ),
                                SizedBox(height: 10 ,),
                                Text("Sales ", style: TextStyle(
                                  color: Colors.white,
                                  
                                ),),
                                Text("Dashboard", style: TextStyle(
                                  color: Colors.white,
                                  
                                ),)
                              ]),
                            ),
                          ),
                          InkWell(
                            onTap:(){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => GenerateReportsScreen(shopId: shopId,) ));
                            },
                            child: Container(
                              width: 150,
                              height: 200,
                              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration:  BoxDecoration(
                                border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
                                borderRadius: BorderRadius.circular(27),
                                color: Colors.deepPurple,
                                gradient:const  LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)])
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.content_paste_search_sharp,
                                color: Colors.deepOrange,
                                size: 35,
                                ),
                                SizedBox(height: 10 ,),
                                Text("Generate", style: TextStyle(
                                  color: Colors.white,
                                  
                                ),),
                                Text("Reports", style: TextStyle(
                                  color: Colors.white,
                                  
                                ),)
                              ]),
                            ),
                          ),
                          
                        
                        ],
                      ),
                    )

                  //  CarouselDemo(),
                    // const Text("Heading"),
                    // ProductListHome(),
                  ],
                ),
                   
 
     );
    // );
  }
}