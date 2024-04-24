import 'package:flutter/material.dart';
import 'package:youapp_code_challenge/extensions/context_extension.dart';
import 'package:youapp_code_challenge/extensions/string_extension.dart';

class MyAppBar extends StatelessWidget{
  String? actionText;
  Function actionClick;
  MyAppBar(this.actionText,this.actionClick, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: ListTile(
        leading: InkWell(
          onTap: (){
            context.back();
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_left, color: Colors.white,),
              SizedBox(width: 5,),
              Text("Back", style: TextStyle(color: Colors.white, fontSize: 16),)
            ],
          ),
        ),
        trailing: actionText != null?
        TextButton(
            onPressed: actionClick(),
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Text(actionText.orEmpty(), style: const TextStyle(
                  fontSize: 16, color: Color(0xFFFFE2BE)),),
            )
        ):const SizedBox(),
      ),
    );
  }

}