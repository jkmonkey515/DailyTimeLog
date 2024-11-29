import 'package:flutter/material.dart';


class LoadingDialog extends StatefulWidget {
  final Function? func;

  const LoadingDialog({Key? key, this.func}) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child:
        contentBox(context)
        ,
      );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30,
          horizontal: 50),
      child: Row(
        children: [
          
          Text("Please wait...")
        ],
      ),
    );
  }
}