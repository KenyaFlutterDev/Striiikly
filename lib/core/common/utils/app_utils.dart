import 'package:flutter/material.dart';

void showBottomSheetForm({
  required BuildContext context,
  required Widget view,
  Function()? onDialogDissmissed,
  bool isDismissible = true,
}) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showModalBottomSheet<void>(
      enableDrag: false,
      context: context,

      isDismissible: isDismissible,
      useSafeArea: true,
      isScrollControlled: true, // Allow the sheet to take up the full height
      useRootNavigator:
          true, //uncomment this to showModalBottomSheet ahead bottomnavigationbar
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (BuildContext context) {
        return view;
      },
    ).whenComplete(() {
      onDialogDissmissed != null ? onDialogDissmissed() : null;
    });
  });
}
