import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarouselDemo extends StatelessWidget {
   CarouselDemo({super.key});
  CarouselController buttonCarouselController = CarouselController();

 @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      CarouselSlider(
        items:  ['assets/ads/baked.jpg',
        'assets/ads/grocery.jpg',
        'assets/ads/cupcakes.jpg'].map((image) 
        {
          // print(image);
    return  Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(),
          child: Image(image: AssetImage(image,
          
          ),  width: double.infinity,
                height: 200,  ),
        );
    
  }).toList(),
        carouselController: buttonCarouselController,
        options: CarouselOptions(
           initialPage: 0,
          autoPlay: true, 
            enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          // initialPage: 2,
        ),
      ),
      ElevatedButton(
        onPressed: () => buttonCarouselController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear),
        child: Text('→'),
      )
    ]
  );
}