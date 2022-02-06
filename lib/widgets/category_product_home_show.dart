import 'package:flutter/material.dart';

class HomeProductShow extends StatelessWidget {
  const HomeProductShow(
      {Key? key,
      required this.imageLoc,
      required this.name,
      required this.price})
      : super(key: key);
  final String imageLoc;
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    // return homeProductView(imageLoc, name, price);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          Positioned.fill(
            child: Image(
              image: AssetImage(imageLoc.toString()),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(price.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
