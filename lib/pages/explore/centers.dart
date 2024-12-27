import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class CentersList extends StatefulWidget {
  const CentersList({super.key});

  @override
  _CentersListState createState() => _CentersListState();
}

class _CentersListState extends State<CentersList> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Therapy Centers',
          style: GoogleFonts.gabarito(
            textStyle: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 0.5),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            color: AppColors.black,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  buildSearch(),
                  buildFilterRow(),
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('centers') // Your Firestore collection name
                        .where('name',
                            isGreaterThanOrEqualTo:
                                _searchQuery) // Search logic
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Something went wrong!'));
                      }

                      if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        var centers = snapshot.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: centers.length,
                          itemBuilder: (context, index) {
                            var center = centers[index];
                            return centersBox(center);
                          },
                        );
                      } else {
                        return Center(child: Text('No centers found.'));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding centersBox(therapyCenters) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 1.0, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    therapyCenters['image'],
                    // Replace with your image URL
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedFavourite,
                      color: Colors.black,
                      size: 15.0, // Smaller icon size
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedShare08,
                      color: Colors.black,
                      size: 15.0, // Smaller icon size
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            therapyCenters['name'],
                            style: GoogleFonts.gabarito(
                              textStyle: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                          Row(
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedLocation01,
                                color: AppColors.lightGray,
                                size: 15.0, // Smaller icon size
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${therapyCenters['location_address']}, ${therapyCenters['location_city']}',
                                style: GoogleFonts.gabarito(
                                  textStyle: const TextStyle(
                                      color: AppColors.lightGray,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.green,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            therapyCenters['ratings'].toString(),
                            style: GoogleFonts.gabarito(
                              textStyle: const TextStyle(
                                  color: AppColors.darkGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Wrap(
                    spacing: 8.0, // Space between chips horizontally
                    runSpacing: 4.0, // Space between chips vertically
                    children:
                        therapyCenters['labels'].entries.map<Widget>((entry) {
                      String labelType = entry.key;
                      return centerChip(entry.value.toString(), labelType);
                    }).toList(), // Convert iterable to list
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Chip centerChip(String detail, String labelType) {
    // Define the icon to be used based on the label type
    IconData icon;

    switch (labelType) {
      case 'grade':
        icon = HugeIcons.strokeRoundedMortarboard02;
        break;
      case 'population':
        icon = HugeIcons.strokeRoundedUserMultiple02;
        break;
      case 'section':
        icon = HugeIcons.strokeRoundedSchool;
        break;
      default:
        icon = HugeIcons.strokeRoundedQuestion; // Default icon
    }

    return Chip(
      visualDensity: VisualDensity.compact,
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: HugeIcon(
          icon: icon,
          color: Colors.black,
          size: 12.0, // Smaller icon size
        ),
      ),
      label: Text(
        detail,
        style: GoogleFonts.gabarito(
          textStyle: const TextStyle(
            color: AppColors.darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 10, // Smaller font size
          ),
        ),
      ),
    );
  }

  Padding buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: TextStyle(color: AppColors.black, fontSize: 12),
        controller: _searchController,
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search for Therapy Centers...',
          hintStyle: TextStyle(color: AppColors.lightGray, fontSize: 12),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0), // Adjust padding around icon
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedSearch01,
              color: Colors.black,
              size: 15.0,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.borderGray, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.borderGray, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.borderGray, width: 1.0),
          ),
        ),
      ),
    );
  }

  Row buildFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // IconButton
        TextButton(
          onPressed: () {
            // Add your onPressed functionality here
            print("Filter button pressed");
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero, // Remove default padding
            minimumSize: Size(40, 40), // Minimum size for the button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              side: BorderSide(
                color: AppColors.borderGray, // Border color
                width: 1.0, // Border width
              ),
            ),
          ),
          child: Center(
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedFilter,
              color: AppColors.black,
              size: 20.0, // Icon size
            ),
          ),
        ),
        ToggleButtons(
          isSelected: [true, false],
          // Initial selection state
          onPressed: (int index) {
            // Handle toggle button press here
            print("Segment $index pressed");
          },
          borderRadius: BorderRadius.circular(10),
          // Adjust radius for smaller buttons
          borderWidth: 0.5,
          // Thinner border
          color: AppColors.black,
          fillColor: AppColors.lightGreen,
          borderColor: AppColors.borderGray,
          selectedBorderColor: AppColors.borderGray,
          constraints: BoxConstraints(
            minWidth: 40.0, // Minimum width for each button
            minHeight: 40.0, // Minimum height for each button
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0), // Reduced padding
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedLayout3Row,
                color: Colors.black,
                size: 16.0, // Smaller icon size
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0), // Reduced padding
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedLayoutGrid,
                color: Colors.black,
                size: 16.0, // Smaller icon size
              ),
            ),
          ],
        ),
      ],
    );
  }
}
