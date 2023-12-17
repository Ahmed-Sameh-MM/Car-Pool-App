import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model%20Classes/custom_route.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';

class Search extends SearchDelegate {

  final List<CustomRoute> routes;

  Search({
    this.routes = const [],
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    List<CustomRoute> temp = [];

    if(query == '') {
      return const SizedBox.shrink();
    }
    
    for(int i = 0; i < routes.length; i++) {
      if(routes[i].name.toLowerCase().contains(query.toLowerCase())) temp.add(routes[i]);
    }

    if(temp.isNotEmpty) {
      return ListView.builder(
        itemCount: temp.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                CustomText(
                  text: temp[index].name,
                ),
                CustomText(
                  text: temp[index].address,
                ),
              ],
            ),
            onTap: () {
              close(context, temp[index]);
            },
          );
        },
      );
    }

    return Center(
      child: CustomText(
        text: 'No results found for "$query"',
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query == '') {
      return ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: CustomText(
              text: routes[index].name,
            ),
            leading: const Icon(
              Icons.history,
              color: Colors.white,
            ),
            onTap: () {
              close(context, routes[index]);
            },
          );
        },
      );
    }

    List<CustomRoute> temp = [];
    for(int i = 0; i < routes.length; i++) {
      if(routes[i].name.toLowerCase().contains(query.toLowerCase())) temp.add(routes[i]);
    }
    if(temp.isNotEmpty) {
      return ListView.builder(
        itemCount: temp.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: CustomText(
              text: temp[index].name,
            ),
            onTap: () {
              close(context, temp[index]);
            },
          );
        },
      );
    }

    return Center(
      child: CustomText(
        text: 'No results found for "$query"',
      ),
    );

  }

}