import 'package:flutter/material.dart';
import '../widgets/profile_card.dart';
import '../widgets/title_section.dart';
import '../widgets/image_section.dart';
import '../widgets/interactive_picker_section.dart';

class AdaptiveProfileScreen extends StatelessWidget {
  const AdaptiveProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: const [
        ProfileCard(),
        SizedBox(height: 8),
        TitleSection(
          name: 'University Technology Sarawak',
          location: 'Sibu, Sarawak',
          starCount: 41,
        ),
        ImageSection(imagePath: 'assets/images/uts.jpg'),
        SizedBox(height: 12),
        InteractivePickerSection(),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: ProfileCard(),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 12.0, right: 12.0, bottom: 12.0),
            children: const [
              TitleSection(
                name: 'University Technology Sarawak',
                location: 'Sibu, Sarawak',
                starCount: 41,
              ),
              ImageSection(imagePath: 'assets/images/uts.jpg'),
              SizedBox(height: 12),
              InteractivePickerSection(),
            ],
          ),
        ),
      ],
    );
  }
}