import 'package:json_annotation/json_annotation.dart';

part 'custom_route.g.dart';

@JsonSerializable()
class CustomRoute {
  String name;
  double price;
  String address;
  String location;

  CustomRoute({
    required this.name,
    required this.price,
    required this.address,
    required this.location,
  });

  factory CustomRoute.fromJson(Map<String, dynamic> json) => _$CustomRouteFromJson(json);

  Map<String, dynamic> toJson() => _$CustomRouteToJson(this);

  static List<CustomRoute> getCustomRoutes() {
    return [
      CustomRoute(
        name: 'Maadi',
        price: 22.5,
        address: 'Address #1',
        location: '',
      ),

      CustomRoute(
        name: 'Fifth Settlement',
        price: 30,
        address: 'Address #2',
        location: '',
      ),

      CustomRoute(
        name: '6 October',
        price: 55,
        address: 'Address #3',
        location: '',
      ),

      CustomRoute(
        name: 'Maadi',
        price: 15,
        address: 'Address #4',
        location: '',
      ),

      CustomRoute(
        name: 'Fifth Settlement',
        price: 10,
        address: 'Address #5',
        location: '',
      ),

      CustomRoute(
        name: '6 October',
        price: 60,
        address: 'Address #6',
        location: '',
      ),

      CustomRoute(
        name: 'Maadi',
        price: 26,
        address: 'Address #7',
        location: '',
      ),

      CustomRoute(
        name: 'Fifth Settlement',
        price: 71,
        address: 'Address #8',
        location: '',
      ),

      CustomRoute(
        name: '6 October',
        price: 5,
        address: 'Address #9',
        location: '',
      ),

      CustomRoute(
        name: 'Maadi',
        price: 40,
        address: 'Address #10',
        location: '',
      ),
    ];
  }
}