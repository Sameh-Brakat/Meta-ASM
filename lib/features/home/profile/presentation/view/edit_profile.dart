import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_app/core/components/text_field_item.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/profile/presentation/view/profile_screen.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  var nameController = TextEditingController(text: 'Sameh Barakat');
  var bioController = TextEditingController(text: 'Software Engineer');
  var locationController = TextEditingController(text: 'Suez');
  var websiteController = TextEditingController(text: 'ASM.com');
  var birthdateController = TextEditingController(text: 'January 25, 2003');
  var pronounsController = TextEditingController(text: 'Sameh Barakat');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                  (route) => false);
            },
            child: Text(
              'Save',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.24,
                  width: double.infinity,
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.17,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      opacity: 0.5,
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.colorDodge),
                      image: AssetImage(
                        'assets/images/photo.jpg',
                      ),
                      fit: BoxFit.cover,
                    )),
                    child: Center(
                      child: Icon(
                        IconBroken.Camera,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                      margin: EdgeInsets.all(15),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          opacity: 0.5,
                          colorFilter: ColorFilter.mode(
                              Colors.black, BlendMode.colorDodge),
                          image: AssetImage(
                            'assets/images/profile.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          IconBroken.Camera,
                          color: Colors.white,
                          size: 40,
                        ),
                      )),
                ),
              ],
            ),
            TextFieldItem('Name', controller: nameController),
            TextFieldItem('Bio', controller: bioController),
            TextFieldItem('Location', controller: locationController),
            TextFieldItem('Website', controller: websiteController),
            TextFieldItem("Birth date", controller: birthdateController),
            TextFieldItem('Pronouns', controller: pronounsController),
          ],
        ),
      ),
    );
  }
}
