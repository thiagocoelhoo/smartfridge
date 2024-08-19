import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  int imageIndex = 0;
  List<Image> images;
  int height;

  Carousel({super.key, required this.images, this.height = 300});

  @override
  State<Carousel> createState() => _Carousel();
}

class _Carousel extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 4,
      child: PageView.builder(
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image(
                image: widget.images[index].image,
                fit: BoxFit.cover
              ),
            ),
          );
        },
      ),
    );
  }
}
