import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/widgets/search_field.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            searchField(),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar() {
    return const SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search),
          SizedBox(width: 10),
          Text('Pesquisa', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      snap: true,
      floating: true,
    );
  }
}
