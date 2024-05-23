import 'package:flutter/material.dart';
import 'navigator_example.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as MBS;

class DragDownIndicator extends StatelessWidget {
  const DragDownIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 12),
          width: 45,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  static const String id = '/MyBottomSheet';

  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> with RouteAware {
  Container sheetNavigator(BuildContext context) {
    return Container(
      height: 28,
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              nestedNavigatorKey.currentState?.maybePop();
            },
          ),*/
          const SizedBox(width: 16),
          const Text('Connect bank'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.93,
        width: double.infinity,
        padding: EdgeInsets.only(
            // We use viewInsets to calculate the height of the keyboard. You don't need
            // this if you don't have a text field in your bottom sheet.
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? MediaQuery.of(context).viewInsets.bottom + 45
                : MediaQuery.of(context).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const DragDownIndicator(),
          //sheetNavigator(context),
          Expanded(
              child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  controller: MBS.ModalScrollController.of(context),
                  slivers: const <Widget>[
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: SetupFlow(
                      setupPageRoute: routeDeviceSetupStartPage,
                    ))
              ]))
        ]));
  }
}
