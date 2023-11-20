class Location {
  String name;
  double price;
  String address;
  String location;

  Location({
    required this.name,
    required this.price,
    required this.address,
    required this.location,
  });

  static List<Location> getLocations() {
    return [
      Location(
        name: 'Maadi',
        price: 22.5,
        address: 'Address #1',
        location: '',
      ),

      Location(
        name: 'Fifth Settlement',
        price: 30,
        address: 'Address #2',
        location: '',
      ),

      Location(
        name: '6 October',
        price: 55,
        address: 'Address #3',
        location: '',
      ),
    ];
  }
}