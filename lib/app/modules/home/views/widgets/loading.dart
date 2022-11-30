import 'package:flutter/material.dart';
import 'package:hyperboliq/app/ui/ui_helpers.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: const [
            Text("Loading..."),
            horizontalSpaceSmall,
            CircularProgressIndicator()
          ]),
        ),
      ),
    );
  }
}
