import 'package:flutter/material.dart';
import 'package:list_widget_demo/app_streams.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});
  @override
  Widget build(BuildContext context) {
    // var list = <Widget>[];
    // for (var i = 0; i <= 100; i++) {
    //   list.add(ListItemWidget(index: i));
    // }
    //return Scaffold(body: ListView.builder(itemCount: list.length, itemBuilder: (context,index)=> list[index]));
    return Scaffold(body: SafeArea(child: ListView.builder(itemCount: 100, itemBuilder: (context,index)=> ListItemWidget(index: index))));
  }
}

class ListItemWidget extends StatefulWidget {
  final int index;
  const ListItemWidget({super.key, required this.index});
  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}


class _ListItemWidgetState extends State<ListItemWidget> with AutomaticKeepAliveClientMixin // AutomaticKeepAliveClientMixin for not updating the current state(refresh)
{
  SimpleStream<int?> counter = SimpleStream();

  @override
  void initState() {
    super.initState();
    counter.update(0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);


    // Stream build is used for not updating the page only the row widget is updated
    return StreamBuilder<int?>(
      initialData: counter.current,
      stream: counter.output,
      builder: (context, snapshot) {
        return Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Expanded(child: Text("Index : ${widget.index}", style: const TextStyle(fontSize: 20, color: Colors.deepPurple) ,textAlign: TextAlign.left,)),
                Expanded(child: Text(snapshot.data.toString(), style: const TextStyle(fontSize: 20) ,textAlign: TextAlign.left,)),
                MaterialButton(
                  color: Colors.deepPurple,
                  onPressed: () {
                    counter.update((counter.current!+1));
                  },
                  child: const Text("+", style: TextStyle(color: Colors.white),),
                )
              ],
            ));
      }
    );
  }

  @override
  bool get wantKeepAlive => true; // If True then the class is not updated and stays with the current state(refresh)
}


/// OLDER SOURCE CODE

// import 'package:flutter/material.dart';
//
// class ListWidget extends StatelessWidget {
//   const ListWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var list = <Widget>[];
//     for (var i = 0; i <= 100; i++) {
//       list.add(const ListItemWidget());
//     }
//     return Scaffold(body: ListView.builder(itemCount: list.length,itemBuilder: (context,index)=> list[index]));
//   }
// }
//
// class ListItemWidget extends StatefulWidget {
//   const ListItemWidget({super.key});
//   @override
//   State<ListItemWidget> createState() => _ListItemWidgetState();
// }
//
//
// class _ListItemWidgetState extends State<ListItemWidget> {
//   var count = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.all(4),
//         child: Row(
//           children: [
//             Text(count.toString()),
//             MaterialButton(
//               onPressed: () {
//                 setState(() {
//                   count++;
//                 });
//               },
//               child: const Text("+"),
//             )
//           ],
//         )
//     );
//   }
// }
