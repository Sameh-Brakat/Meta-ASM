import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/components/text_field_item.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/home_page/presentation/controller/home_cubit/home_cubit.dart';
import 'package:social_app/features/home/profile/presentation/controller/profile_cubit.dart';
import 'package:social_app/features/home/profile/presentation/controller/profile_states.dart';
import 'package:social_app/features/home/profile/presentation/view/profile_screen.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  var nameController = TextEditingController(text: HomeCubit.userModel!.name);
  var bioController = TextEditingController(text: HomeCubit.userModel!.bio);
  var locationController = TextEditingController(text: 'Suez');
  var websiteController = TextEditingController(text: 'ASM.com');
  var birthdateController =
      TextEditingController(text: HomeCubit.userModel!.date);
  var emailController = TextEditingController(text: HomeCubit.userModel!.email);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // create: (context) => ProfileCubit(),
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is UpdateImageSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text(
                'Edit Profile',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.updateUserProfile(context,
                        name: nameController.text,
                        email: emailController.text,
                        bio: bioController.text);
                  },
                  child: const Text(
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
                      SizedBox(
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
                            image: cubit.coverImage != null
                                ? DecorationImage(
                                    opacity: 0.5,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black, BlendMode.colorDodge),
                                    image: FileImage(
                                      cubit.coverImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : HomeCubit.userModel!.cover != null
                                    ? DecorationImage(
                                        opacity: 0.5,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.black, BlendMode.colorDodge),
                                        image: NetworkImage(
                                            HomeCubit.userModel!.cover!),
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        opacity: 0.5,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black, BlendMode.colorDodge),
                                        image: AssetImage(
                                            'assets/images/photo.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                IconBroken.Camera,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                cubit.chooseCoverImage();
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              borderRadius: BorderRadius.circular(50),
                              image: cubit.profileImage != null
                                  ? DecorationImage(
                                      opacity: 0.5,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black, BlendMode.colorDodge),
                                      image: FileImage(
                                        cubit.profileImage!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : HomeCubit.userModel!.image != null
                                      ? DecorationImage(
                                          opacity: 0.5,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.black,
                                              BlendMode.colorDodge),
                                          image: NetworkImage(
                                              HomeCubit.userModel!.image!),
                                          fit: BoxFit.cover,
                                        )
                                      : const DecorationImage(
                                          opacity: 0.5,
                                          colorFilter: ColorFilter.mode(
                                              Colors.black,
                                              BlendMode.colorDodge),
                                          image: AssetImage(
                                              'assets/images/profile.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                            ),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    ProfileCubit.get(context)
                                        .chooseProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                            )),
                      ),
                    ],
                  ),
                  TextFieldItem('Name', controller: nameController),
                  TextFieldItem('Email', controller: emailController),
                  TextFieldItem('Bio', controller: bioController),
                  TextFieldItem("Birth date", controller: birthdateController),
                  TextFieldItem('Location', controller: locationController),
                  TextFieldItem('Website', controller: websiteController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
