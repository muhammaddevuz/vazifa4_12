import 'package:dars_12/controllers/location_controller.dart';
import 'package:dars_12/models/location.dart';
import 'package:dars_12/views/widgets/add_location.dart';
import 'package:dars_12/views/widgets/location_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationController = Provider.of<LocationController>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: StreamBuilder(
          stream: locationController.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "Locationlar mavjud emas",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              );
            }

            final locations = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Aspect ratio of the items
              ),
              itemCount: locations.length,
              itemBuilder: (context, index) {
                Location location = Location.fromJson(locations[index]);
                return LocationItem(location: location);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => AddLocation(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
