import 'package:flutter/material.dart';
import 'package:runnin_us/const/color.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return renderGrid();
  }

  Widget renderGrid(){
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(9, (index) {
        return Center(
          child: Text(
            '아이템 $index',
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      }),
    );
  }
}
