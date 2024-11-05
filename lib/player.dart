import 'package:flutter/material.dart';

class BottomPlayerBar extends StatelessWidget {
  BottomPlayerBar({super.key});
  
  final Map<int, bool> isStart = {};
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aayiram Jannal Veedu",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Rahul Nambiar",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow_rounded,color: Colors.white,),
                onPressed: (){},
              ),
              IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                onPressed: (){
                  const Icon(Icons.favorite,color: Colors.red,);
                }, 
                icon: const Icon(Icons.favorite_border,color: Colors.white,)
              )
            ],
          ),
        ],
      ),
    );
  }
}
