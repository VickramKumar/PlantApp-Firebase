// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:plant_app/exports/exports.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileScreenProvider provider =
        Provider.of<ProfileScreenProvider>(context, listen: false);

    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        provider.newPasswordController.clear();
        provider.currentPasswordController.clear();
        provider.imagePath = '';
      },
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomLoadingIndicator(color: MyColors.black);
          } else {
            return Scaffold(
              backgroundColor: MyColors.white,
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: MyColors.appColor,
                iconTheme: const IconThemeData(color: MyColors.white),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Selector<ProfileScreenProvider, String>(
                              selector: (context, selector) =>
                                  selector.imagePath,
                              builder: (context, value, child) {
                                String image = snapshot.data!.data()!['image'];

                                return Container(
                                  height: 20.h,
                                  width: 20.h,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColors.appColor,
                                  ),
                                  child: provider.imagePath == '' && image == ''
                                      ? Icon(Icons.person, size: 15.h)
                                      : provider.imagePath != ''
                                          ? Image.file(
                                              File(provider.imagePath),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                );
                              },
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(100.h),
                              color: const Color.fromARGB(255, 220, 220, 220),
                              child: InkWell(
                                onTap: () {
                                  provider.pickImage(ImageSource.camera);
                                },
                                borderRadius: BorderRadius.circular(100.h),
                                child: Padding(
                                  padding: EdgeInsets.all(1.h),
                                  child: Icon(
                                    Icons.edit,
                                    size: 15.sp,
                                    color: MyColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        'Name',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 75, 75, 75),
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        icon: Icons.email,
                        hintText: 'enter your name',
                        controller: provider.nameController,
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        'Current Password',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 75, 75, 75),
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        icon: Icons.lock,
                        hintText: 'enter your current password',
                        controller: provider.currentPasswordController,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'New Password',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 75, 75, 75),
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      CustomTextField(
                        icon: Icons.lock,
                        hintText: 'enter new password',
                        controller: provider.newPasswordController,
                      ),
                      SizedBox(height: 7.h),
                      Selector<ProfileScreenProvider, bool>(
                        selector: (context, selector) => selector.loading,
                        builder: (context, value, child) {
                          return MyButton(
                            text: 'Save',
                            loading: value,
                            onTap: () {
                              provider.uploadEditedData(
                                context,
                                snapshot.data!.data()!['password'],
                                snapshot.data!.data()!['image'],
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
