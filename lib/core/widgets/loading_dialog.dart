import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: const Column(
            children: [
              CircularProgressIndicator(),
              Text('Loading...'),
            ],
          ),
        )
      ]),
    );
  }
}
