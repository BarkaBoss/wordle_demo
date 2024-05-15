import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showMessage(BuildContext context, String message)=>
    ScaffoldMessenger.of(context).
    showSnackBar(SnackBar(content
        : Text(message)));

void showResult({
  required BuildContext context,
  required String  title,
  required String body,
  required VoidCallback onPlayAgain,
  required VoidCallback onCancel,
}){
  showDialog(context: context, builder: (context)=> AlertDialog(
    title: Text(title),
    content: Text(body),
    actions: [
      TextButton(onPressed: onCancel, child: const Text("QUIT")),
      TextButton(onPressed: onPlayAgain, child: const Text("GO AGAIN"))
    ],
  ));
}

void showMsg({
  required BuildContext context,
  required String title,
  required String body,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  required IconData iconData
}){
  showDialog(context: context, builder: (context)=> AboutDialog(
    children: [
      Center(
        child: Icon(iconData, color: Colors.red,),
      ),
      Text(title),
      Text(body),

      Row(
        children: [
          ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              child: Text("Confirm")
          ),
          ElevatedButton(onPressed: onCancel,
              child: Text("Cancel")
          ),
        ],
      )
    ],
  ));
}

void showDia({
  required BuildContext context,
  required String title,
  required String body,
  required bool isChecked,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  required Widget checkBox
}){
    showDialog(context: context, builder: (context)=> Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.delete_forever, size:
                  50, color: Colors.white,),
              style: IconButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: Colors.red
              ),
            ),
            SizedBox(height: 10,),
            const Text("Block/Report User"),
            const Center(
              child: Text("Blocking a user would remove the user and you will not "
                  "be able to interact with this user within the app",
              textAlign: TextAlign.center),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                checkBox,
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Report User", textAlign: TextAlign.left,),
                    Text("Reported users will be removed within 24 hours",
                      style: TextStyle(fontSize: 9),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                )

              ],
            ),
            SizedBox(height: 20,),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: (){
                  Navigator.of(context).pop(false);
                },
                    child: Text("Report"),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop(false);
                },
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    )
  );
}