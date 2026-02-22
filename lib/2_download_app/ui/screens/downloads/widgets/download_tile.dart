import 'package:flutter/material.dart';
import '../../../providers/theme_color_provider.dart'; 
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
 
 // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, _) {
        Widget? subtitleWidget;

        if (controller.status == DownloadStatus.downloading ||
            controller.status == DownloadStatus.downloaded) {
          subtitleWidget = Text(
            '${(controller.progress * 100).toStringAsFixed(1)}% completed - '
            '${(controller.progress * controller.ressource.size).toStringAsFixed(1)} of '
            '${controller.ressource.size} MB',
            style: TextStyle(
              fontSize: 12,
              color: themeProvider.mainColor,
            ),
          );
        } else {
          subtitleWidget = Text(" ");
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(8), 
          ),
          child: ListTile(
            title: Text(controller.ressource.name),
            trailing: Icon(
              switch (controller.status) {
                DownloadStatus.notDownloaded => Icons.download,
                DownloadStatus.downloading => Icons.downloading,
                DownloadStatus.downloaded => Icons.folder,
              },
            ),
            subtitle: subtitleWidget,
            onTap: controller.startDownload,
          ),
        );
      },
    );
  }
}
