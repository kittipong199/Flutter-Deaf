import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageBottomSelectWidget extends StatelessWidget {
  final VoidCallback? onGallery;
  final VoidCallback? onCamera;
  ImageBottomSelectWidget(
      {super.key, required this.onGallery, required this.onCamera});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.size.height * 0.3,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Restaurant Photo',
              style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MaterialButton(
                onPressed: onGallery,
                child: Column(
                  children: [
                    Icon(
                      Icons.image,
                      color: Color(0XFFFDCD03),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Gallery',
                      style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Color(0XFFFDCD03),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              MaterialButton(
                onPressed: onCamera,
                child: Column(
                  children: [
                    Icon(
                      Icons.image,
                      color: Color(0XFFFDCD03),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Camera',
                      style: GoogleFonts.kanit(
                          fontSize: 20,
                          color: Color(0XFFFDCD03),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}




    // Center(
    //           child: Stack(
    //             children: [
    //               Container(
    //                 width: 180,
    //                 height: 180,
    //                 decoration: BoxDecoration(
    //                   border: Border.all(
    //                       width: 4,
    //                       color: Theme.of(context).scaffoldBackgroundColor),
                    
                    
    //                 ),
    //               ),
    //               Positioned(
    //                 bottom: 0,
    //                 right: 10,
    //                 child: Container(
    //                     height: 40,
    //                     width: 40,
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       border: Border.all(
    //                         width: 4,
    //                         color: Theme.of(context).scaffoldBackgroundColor,
    //                       ),
    //                       color: Colors.green,
    //                     ),
    //                     child: InkWell(
    //                       onTap: () => chooseImage(ImageSource.gallery),
    //                       child: Icon(
    //                         // icon: Icon(
    //                         //   Icons.edit,
    //                         // ),
    //                         // onPressed: () => chooseImage(ImageSource.camera),
    //                         Icons.add_photo_alternate,
    //                         color: Colors.white,
    //                       ),
    //                     )),
    //               ),
    //                Positioned(
    //                 bottom: 0,
    //                 right: 120,
    //                 child: Container(
    //                     height: 40,
    //                     width: 40,
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       border: Border.all(
    //                         width: 4,
    //                         color: Theme.of(context).scaffoldBackgroundColor,
    //                       ),
    //                       color: Color.fromARGB(255, 55, 128, 207),
    //                     ),
    //                     child: InkWell(
    //                       onTap: () => chooseImage(ImageSource.camera),
    //                       child: Icon(
    //                         // icon: Icon(
    //                         //   Icons.edit,
    //                         // ),
    //                         // onPressed: () => chooseImage(ImageSource.camera),
    //                         Icons.add_a_photo_outlined,
    //                         color: Colors.white,
    //                       ),
    //                     )),
    //               )
    //             ],
    //           ),
    //         ),