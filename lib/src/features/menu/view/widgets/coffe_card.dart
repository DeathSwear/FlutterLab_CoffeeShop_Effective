import 'package:flutter/material.dart';

class CoffeCard extends StatelessWidget {
  const CoffeCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical:  16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              image: AssetImage('lib/src/assets/images/rrr.png'),
              height: 100,
            ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Олеато'),
          ),
          SizedBox(
            height: 24,
            width: 116,
            child: TextButton( //не бейте, это пока что просто скелет...
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  //fixedSize: const Size(116, 24),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.zero,
              ),
              child: Text('100 руб'),
            ),
          )

        ],
      ),
    );

  }
}
