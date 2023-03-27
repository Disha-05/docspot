import 'package:flutter/material.dart';
import 'dart:math';

class Doctor {
  final String hospitalName;
  final String name;
  final String availability;
  final String specialty;
  final double distance;
  final double longitude;
  final double latitude;

  Doctor(
      {required this.hospitalName,
      required this.name,
      required this.availability,
      required this.specialty,
      required this.distance,
      required this.longitude,
      required this.latitude});
}

class DoctorSearchPage extends StatefulWidget {
  @override
  _DoctorSearchPageState createState() => _DoctorSearchPageState();
}

class _DoctorSearchPageState extends State<DoctorSearchPage> {
  final List<Doctor> _doctors = [
    Doctor(
        hospitalName: 'Hospital A',
        name: 'Dr. John Doe',
        specialty: 'Cardiology',
        availability: 'yes',
        distance: 5.3,
        longitude: -73.9857,
        latitude: 40.7484),
    Doctor(
        hospitalName: 'Hospital A',
        name: 'Dr. John Doe',
        specialty: 'Cardiology',
        availability: 'yes',
        distance: 5.3,
        longitude: -73.9857,
        latitude: 40.7484),
    Doctor(
        hospitalName: 'Hospital A',
        name: 'Dr. Jane Smith',
        specialty: 'Pediatrics',
        availability: 'yes',
        distance: 7.2,
        longitude: -73.9857,
        latitude: 40.7484),
    Doctor(
      hospitalName: 'Hospital B',
      name: 'Dr. Tom Johnson',
      specialty: 'Orthopedics',
      availability: 'yes',
      distance: 3.8,
      longitude: -73.9857,
      latitude: 40.7484,
    ),
    Doctor(
      hospitalName: 'Hospital C',
      name: 'Dr. Sarah Lee',
      specialty: 'Dermatology',
      availability: 'yes',
      distance: 12.4,
      longitude: -73.9857,
      latitude: 40.7484,
    ),
    Doctor(
      hospitalName: 'Hospital A',
      name: 'Dr. Hannah Roger',
      specialty: 'Dermatology',
      availability: 'yes',
      distance: 11,
      longitude: -73.9857,
      latitude: 40.7484,
    ),
  ];
  List<Doctor> _searchResults = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    String searchText = _searchController.text.toLowerCase();
    List<Doctor> filteredDoctors = _doctors
        .where((doctor) => doctor.specialty.toLowerCase().contains(searchText))
        .toList();
    filteredDoctors.sort((a, b) => a.distance.compareTo(b.distance));
    setState(() {
      _searchResults = filteredDoctors;
    });
  }

  void _onTileClicked(Doctor doctor) {
    print("Hello");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for a specialist...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          Doctor doctor = _searchResults[index];
          return InkWell(
            onTap: () => _onTileClicked(doctor),
            child: ListTile(
              title: Text(doctor.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.specialty),
                  Text('${doctor.distance} miles away'),
                  Text('At ${doctor.hospitalName}'),
                  Text('Availablity: ${doctor.availability}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
