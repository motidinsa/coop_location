import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogOptionSelect extends StatelessWidget {
  final String title;
  final int? listIndex;

  const AlertDialogOptionSelect({super.key, required this.title, this.listIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 15,
          bottom:
              // title != selectSourceN && !isAlertDialogListEmpty(title: title)
              //     ?
              15
                  // : 0
          ,
        ),
        shape:SmoothRectangleBorder(
          borderRadius: 15,
          side: BorderSide.none,
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        content: SizedBox(
          width:  double.maxFinite ,
          child: ListView(
                  shrinkWrap: true,
                  physics: isSearchedListEmpty
                      ? const NeverScrollableScrollPhysics()
                      : const ClampingScrollPhysics(),
                  children: [
                    if (!isAlertDialogListEmpty(title: title))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomTextField(
                          title: title,
                          index: listIndex,fillColor: Colors.white54,
                        ),
                      ),
                    isSearchedListEmpty && !isAlertDialogListEmpty(title: title)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                getEmptySearchResult(title: title),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey.shade700),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AlertDialogOptionItem(
                                  title: title,
                                  listIndex: [
                                    RouteName.addPurchase,
                                    RouteName.addSales
                                  ].contains(Get.currentRoute)
                                      ? listIndex
                                      : null,
                                  index: index);
                            },
                            itemCount: getAlertDialogOptionLists(
                              title: title,
                            ).length,
                          ),
                    if (isSearchedListEmpty) const SizedBox(height: 8),
                    if (isAlertDialogListEmpty(title: title))
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Text(
                          getEmptyMessage(title: title),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            // fontStyle: FontStyle.italic,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8)
                  ],
                ),
        ),
      ),
    );
  }
}
