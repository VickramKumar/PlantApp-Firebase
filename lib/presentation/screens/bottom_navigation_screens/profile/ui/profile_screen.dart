import 'package:plant_app/exports/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileScreenProvider provider =
        Provider.of<ProfileScreenProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CustomLoadingIndicator();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 18.h,
                    height: 18.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: snapshot.data!.data()!['image'] == ''
                        ? Image.asset(
                            MyImages.profile,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            snapshot.data!.data()!['image'],
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.data()!['name'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                      ),
                      Image.asset(
                        MyImages.verified,
                        height: 3.h,
                      ),
                    ],
                  ),
                  Text(
                    snapshot.data!.data()!['email'],
                    style: TextStyle(
                      color: Colors.black.withOpacity(.3),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: MyButton(
                      text: 'Edit Profile',
                      height: 6.h,
                      onTap: () {
                        provider.nameController.text =
                            snapshot.data!.data()!['name'];

                        Get.to(
                          () => const EditProfileScreen(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ProfileWidget(
                        icon: Icons.person,
                        title: 'My Profile',
                      ),
                      const ProfileWidget(
                        icon: Icons.settings,
                        title: 'Settings',
                      ),
                      const ProfileWidget(
                        icon: Icons.notifications,
                        title: 'Notifications',
                      ),
                      const ProfileWidget(
                        icon: Icons.chat,
                        title: 'FAQs',
                      ),
                      const ProfileWidget(
                        icon: Icons.share,
                        title: 'Share',
                      ),
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut().then(
                            (value) {
                              Get.to(() => const LoginScreen());
                            },
                          );
                        },
                        child: const ProfileWidget(
                          icon: Icons.logout,
                          title: 'Log Out',
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
