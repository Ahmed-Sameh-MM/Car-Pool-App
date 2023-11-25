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

      Location(
        name: 'Maadi',
        price: 15,
        address: 'Address #4',
        location: '',
      ),

      Location(
        name: 'Fifth Settlement',
        price: 10,
        address: 'Address #5',
        location: '',
      ),

      Location(
        name: '6 October',
        price: 60,
        address: 'Address #6',
        location: '',
      ),

      Location(
        name: 'Maadi',
        price: 26,
        address: 'Address #7',
        location: '',
      ),

      Location(
        name: 'Fifth Settlement',
        price: 71,
        address: 'Address #8',
        location: '',
      ),

      Location(
        name: '6 October',
        price: 5,
        address: 'Address #9',
        location: '',
      ),

      Location(
        name: 'Maadi',
        price: 40,
        address: 'Address #10',
        location: '',
      ),
    ];
  }
}