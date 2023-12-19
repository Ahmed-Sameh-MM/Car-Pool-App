import 'package:driver_car_pool_app/Services/errors.dart';
import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Model%20Classes/custom_route.dart';
import 'package:driver_car_pool_app/Services/realtime_db.dart';
import 'package:driver_car_pool_app/Widgets/routes_list_view.dart';
import 'package:driver_car_pool_app/Widgets/search.dart';
import 'package:driver_car_pool_app/Screens/chosen_route_screen.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({ super.key });

  static const routeName = '/routes';

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {

  Future<List>? schoolsFuture;

  final List<String> sort = ['Alphabetically [A-Z]', 'Alphabetically [Z-A]', 'Lowest to Highest Price', 'Highest to Lowest Price'];

  late String currentSort;

  late Future< List<CustomRoute> > routesFuture;

  late List<CustomRoute> routes;

  void showSortList() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setSheetState) {
            return SizedBox(
              height: 230,
              child: ListView.builder(
                itemCount: sort.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(sort[index]),
                    onTap: () {
                      setSheetState(() {
                        setState(() {
                          currentSort = sort[index];
                        });
                      });
                    },
                    leading: Radio(
                      value: sort[index],
                      groupValue: currentSort,
                      onChanged: (value) {
                        setSheetState(() {
                          setState(() {
                            currentSort = value!;
                          });
                        });
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void sorting() {
    if(currentSort == 'Lowest to Highest Price') {
      routes.sort(
        (CustomRoute l1, CustomRoute l2) {
          return l1.price.compareTo(l2.price);
        }
      );
    }

    else if(currentSort == 'Highest to Lowest Price') {
      routes.sort(
        (CustomRoute l1, CustomRoute l2) {
          return l2.price.compareTo(l1.price);
        }
      );
    }

    else if(currentSort == 'Alphabetically [A-Z]') {
      routes.sort(
        (CustomRoute l1, CustomRoute l2) {
          return l1.name.toLowerCase().compareTo(l2.name.toLowerCase());
        }
      );
    }

    else if(currentSort == 'Alphabetically [Z-A]') {
      routes.sort(
        (CustomRoute l1, CustomRoute l2) {
          return l2.name.toLowerCase().compareTo(l1.name.toLowerCase());
        }
      );
    }
  }

  Future< List<CustomRoute> > initRoutes() async {
    final temp = await getRoutes();

    return temp.fold(
      (error) {
        return Future< List<CustomRoute> >.error(error);
      },
      (success) {
        return Future< List<CustomRoute> >.value(success);
      },
    );
  }

  @override
  void initState() {
    currentSort = sort[0];

    routesFuture = initRoutes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {

              final searchResult = await showSearch(
                context: context,
                delegate: Search(routes: routes,),
              );
              
              if(searchResult != null && context.mounted) {
                Navigator.pushNamed(context, ChosenRouteScreen.routeName, arguments: searchResult);
              }
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Row(
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: Color(0xFF707070),
                    ),
                    right: BorderSide(
                      width: 0.5,
                      color: Color(0xFF707070),
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: showSortList,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                      WSizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: 'Sort',
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 45,
                width: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: Color(0xFF707070),
                    ),
                    left: BorderSide(
                      width: 0.5,
                      color: Color(0xFF707070),
                    ),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    WSizedBox(
                      width: 5,
                    ),
                    CustomText(
                      text: 'Filters',
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: Center(
        child: FutureBuilder(
          future: routesFuture,
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
                return const CustomText(
                  text: 'None',
                  size: 30,
                );
      
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator(
                  strokeWidth: 2,
                ); 
      
              case ConnectionState.done:
                if(snapshot.hasError) {
                  final error = snapshot.error as ErrorTypes;
                  
                  return CustomText(
                    text: error.errorMessage,
                    size: 20,
                  );
                }
      
                else if(snapshot.hasData) {
                  routes = snapshot.data as List<CustomRoute>;
                  return RoutesListView(
                    routes: routes,
                  );
                }
      
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}