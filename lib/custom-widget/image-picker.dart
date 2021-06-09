import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:medvarsity_task/theme/theme-one.dart';


class SnImagePicker extends StatelessWidget {
  final BuildContext context;
  final ValueChanged<ImageSource> onSourceChanged;

  SnImagePicker({this.context, this.onSourceChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: [
          Material(
            child: InkWell(
                splashColor: white,
                child: ListTile(
                    leading: Icon(Icons.camera_alt), title: Text('Camera')),
                onTap: () => onSourceChanged(ImageSource.camera)),
          ),
          Material(
            child: InkWell(
                splashColor: white,
                child: ListTile(
                    leading: Icon(Icons.photo), title: Text('Gallery')),
                onTap: () => onSourceChanged(ImageSource.gallery)),
          )
        ],
      ),
    );
  }
}
