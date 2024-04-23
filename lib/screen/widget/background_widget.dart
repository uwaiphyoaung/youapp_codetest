import 'package:flutter/cupertino.dart';

class BgView extends StatelessWidget{
  const BgView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF09141A),
              Color(0xFF1F4247),
            ],
            begin: FractionalOffset(0.0, 1.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.decal),
      ),
    );
  }

}