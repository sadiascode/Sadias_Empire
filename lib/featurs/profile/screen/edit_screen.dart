import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sadias_empire/featurs/profile/screen/profile_screen.dart';
import '../../../common/app_shell.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_button.dart';
import '../../../common/custom_color.dart';
import '../widget/custom_edit.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final ImagePicker _picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    final role = AppState.currentRole;
    final isSeller = role == UserRole.seller;

    return SubPageScaffold(
      parentTabIndex: 4,
      backgroundColor: const Color(0xFF121215),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xFF121215),
        title: const Text(
          "EDIT  PROFILE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColors.primaryGradient,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  // Pick an image.
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                },
                child: const Text(
                  'Change photo',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLight,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.textLight,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomEdit(
                title: isSeller ? "Store Name" : "Full Name",
                hintText: isSeller ? "Enter your store name" : "Enter your full name",
              ),
              const SizedBox(height: 15),
              CustomEdit(
                title: isSeller ? "FFL License" : "Email",
                hintText: isSeller ? "Enter your FFL License" : "Enter your email",
              ),

              const SizedBox(height: 50),
              CustomButton(
                text: "Save",
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}