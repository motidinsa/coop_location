import 'package:coop_location/home/controller.dart';
import 'package:coop_location/home/custom_text_field_2.dart';
import 'package:coop_location/home/functions.dart';
import 'package:coop_location/home/shadowed_container.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart' as loc;

import 'home/action_button.dart';
import 'home/parse_init.dart';
// import 'package:location/location.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  parseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Color(0xff00AEEF),
                strokeWidth: 3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Submitting, please wait',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                ),
              )
            ],
          ),
        );
      },
      child: GetMaterialApp(
        title: 'Coop location',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff00AEEF)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Coop location'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  loc.Location location = loc.Location();

  @override
  void initState() {
    Get.put<Controller>(Controller());
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: ShadowedContainer(
            child: GetBuilder<Controller>(builder: (controller) {
              if (controller.isSubmitting) {
                executeAfterBuild(() {
                  context.loaderOverlay.show();
                });
              } else {
                executeAfterBuild(() {
                  context.loaderOverlay.hide();
                });
              }
              return ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  Form(
                    key: controller.formKey,
                    // autovalidateMode: addProductController.isSubmitButtonPressed?AutovalidateMode.always:null,

                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) => CustomTextField2(
                        title: controller.titles[index],
                        index: index,
                      ),
                      separatorBuilder: (ctx, index) => SizedBox(
                        height: 15,
                      ),
                      itemCount: controller.titles.length,
                      shrinkWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.isLocationLoading) ...[
                        Text('Fetching location'),
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xff00AEEF),
                            ))
                      ] else if (controller.locationError) ...[
                        Text('Some error occured'),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              getCurrentPosition();
                            },
                            child: Text(
                              'Retry',
                              style: TextStyle(color: Color(0xff00AEEF)),
                            ))
                      ] else
                        Column(
                          children: [
                            Text(
                                'Coordinate: ${controller.latitude},${controller.longitude}'),
                            SizedBox(
                              height: 5,
                            ),
                            TextButton(
                                onPressed: () {
                                  getCurrentPosition();
                                },
                                child: Text(
                                  'Refresh location',
                                  style: TextStyle(color: Color(0xff00AEEF)),
                                ))
                          ],
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 15, left: 10, right: 10),
                    child: ActionButton(),
                  ),
                ],
              );
            }),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
