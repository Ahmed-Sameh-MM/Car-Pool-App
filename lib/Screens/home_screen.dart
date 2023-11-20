import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Model%20Classes/location.dart';
import 'package:car_pool_app/Screens/chosen_location_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key });

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List>? schoolsFuture;

  final List<String> sort = ['Alphabetically [A-Z]', 'Alphabetically [Z-A]', 'Lowest to Highest Price', 'Highest to Lowest Price'];

  late String currentSort;

  late List<Location> locationsList;

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
      locationsList.sort(
        (Location l1, Location l2) {
          return l1.price.compareTo(l2.price);
        }
      );
    }

    else if(currentSort == 'Highest to Lowest Price') {
      locationsList.sort(
        (Location l1, Location l2) {
          return l2.price.compareTo(l1.price);
        }
      );
    }

    else if(currentSort == 'Alphabetically [A-Z]') {
      locationsList.sort(
        (Location l1, Location l2) {
          return l1.name.toLowerCase().compareTo(l2.name.toLowerCase());
        }
      );
    }

    else if(currentSort == 'Alphabetically [Z-A]') {
      locationsList.sort(
        (Location l1, Location l2) {
          return l2.name.toLowerCase().compareTo(l1.name.toLowerCase());
        }
      );
    }
  }

  @override
  void initState() {
    currentSort = sort[0];

    locationsList = Location.getLocations();

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

              // final searchResult = await showSearch(
              //   context: context,
              //   delegate: Search(locationsList: locationsList,),
              // );
              
              // if(searchResult != null) {
              //   Navigator.pushNamed(context, ChosenLocationScreen.routeName, arguments: searchResult);
              // }
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
                      Icon(Icons.sort),
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
                    Icon(Icons.filter_list),
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

      body: ListView.builder(
        itemCount: locationsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20,),
            child: CustomButton(
              shadow: false,
              borderRadius: 5,
              onTap: () {
                final locationData = locationsList[index];
                Navigator.pushNamed(context, ChosenLocationScreen.routeName,arguments: locationData);
              },
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/${locationsList[index].name}.jpg'
                        ),
                        opacity: .8,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: locationsList[index].name,
                          size: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        const HSizedBox(
                          height: 10,
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_pin),
                                CustomText(
                                  text: locationsList[index].address,
                                  size: 13,
                                  textColor: Colors.white60,
                                ),
                              ],
                            ),
                            CustomText(
                              text: '${locationsList[index].price} EGP',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}