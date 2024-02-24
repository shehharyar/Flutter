import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final String shopId;

  const ImageCarousel({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child('products')
          .orderByChild('shopId')
          .equalTo(shopId)
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        List<String> imageUrls = [];

        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
        final data = snapshot.data!.snapshot.value;
        final List<dynamic> loadedProducts = data == null ? [] : List.from((data as Map<dynamic, dynamic>).values);
        //  Object? data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
 loadedProducts.forEach((product) {
    if (product['imageUrl'] != null) {
      imageUrls.add(product['imageUrl']);
    }
  });
        print("Images $imageUrls ");
          // data.values.forEach((value) {
          //   if (value['imageUrl'] != null) {
          //     imageUrls.add(value['imageUrl']);
          //   }
        
        }

        return imageUrls.isEmpty ?
        Container(
                        margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 72, 19, 85), width: 2.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(

                          child:
                          
                           Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                              Icon(Icons.camera_enhance_sharp, color: Color.fromARGB(255, 246, 244, 247),
                              size:30
                              ),
                               Text(
                                "No data available",
                                style: TextStyle(color: Colors.white),
                                                         ),
                             ],
                           ),
                        ),
                      ) 
       
         : CarouselSlider(
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
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
        );
      },
    );
  }
}
