import 'package:flutter/material.dart';

class CropInfo extends StatelessWidget {
  const CropInfo({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //const Color.fromRGBO(245, 245, 219, 1),
      body: SafeArea( // SafeArea yung visible part ng screen.
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: const Column(
            children: [
              SizedBox(height: 11,),
              Center(
                child: Text('Oust Francis'),

              )
            ],
          ),
        ),
      ),
    );
  }

}
