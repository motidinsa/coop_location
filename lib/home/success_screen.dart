import 'package:coop_location/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'functions.dart';

class SuccessScreen extends StatelessWidget {
  SuccessScreen({super.key});

  final Controller controller = Controller.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 120,
                color: Color(0xff00AEEF),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Thank you!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00AEEF),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'The following data was successfully submitted',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff00AEEF),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => index == 4 && controller.type!='Branch'?Container():RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.grey.shade800),
                          children: [
                            TextSpan(
                              text: controller.type == 'Branch' &&
                                      controller.titles[index] == 'Phone number'
                                  ? 'Branch phone number:  '
                                  : '${controller.titles[index]}:  ',
                              style: TextStyle(
                                  fontSize: 18,
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  titleToData(title: controller.titles[index]),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                  separatorBuilder: (ctx, index) => SizedBox(
                        height: index == 4 && controller.type!='Branch'?0:5,
                      ),
                  itemCount: controller.titles.length),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(MyHomePage());
                          controller.type = '';
                          controller.district = '';
                          controller.branch = '';
                          controller.branchCode = '';
                          controller.phoneNumber = '';
                          controller.region = '';
                          controller.city = '';
                          controller.street = '';
                          controller.latitude = 0;
                          controller.longitude = 0;
                          controller.isLocationLoading = false;
                          controller.locationError = false;
                          controller.isSubmitting = false;
                          controller.isSubmitButtonPressed=false;
                          controller.update();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          backgroundColor: Color(0xff00AEEF).withOpacity(.8),
                        ),
                        child: Text(
                          'Add another record',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
