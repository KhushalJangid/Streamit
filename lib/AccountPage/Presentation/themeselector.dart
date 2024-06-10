import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:streamit/DatabaseConfig/storagemanager.dart';

showThemeSelector(BuildContext context) {
  int selectedTheme = -1;
  setThemeMode(String themeMode) {
    if (themeMode == "light") {
      selectedTheme = 0;
    } else if (themeMode == "dark") {
      selectedTheme = 1;
    } else {
      selectedTheme = 2;
    }
  }

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder(
            future: StorageManager.readData("themeMode"),
            builder: (context, s) {
              if (s.hasData) {
                setThemeMode(s.data as String);
                return StatefulBuilder(builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Select a theme",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Radio(
                            value: 0,
                            groupValue: selectedTheme,
                            onChanged: (string) {
                              setState(() {
                                selectedTheme = 0;
                                AdaptiveTheme.of(context).setLight();
                                StorageManager.saveData('themeMode', 'light');
                              });
                            },
                          ),
                          const Text("Light"),
                        ]),
                        Row(children: [
                          Radio(
                            value: 1,
                            groupValue: selectedTheme,
                            onChanged: (string) {
                              setState(() {
                                selectedTheme = 1;
                                AdaptiveTheme.of(context).setDark();
                                StorageManager.saveData('themeMode', 'dark');
                              });
                            },
                          ),
                          const Text("Dark"),
                        ]),
                        Row(children: [
                          Radio(
                            value: 2,
                            groupValue: selectedTheme,
                            onChanged: (string) {
                              setState(() {
                                selectedTheme = 2;
                                AdaptiveTheme.of(context).setSystem();
                                StorageManager.saveData('themeMode', 'system');
                              });
                            },
                          ),
                          const Text("System"),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Done"),
                        ),
                      ],
                    ),
                  );
                });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      });
}
