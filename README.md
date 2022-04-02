<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Some nice utils made by MicroProgramers.

## Features

This package includes:

- custom_animated_widget
- custom_bottom_navigation
- custom_button
- custom_checkbox
- custom_chips
- custom_input_field
- custom_input_formatter
- custom_listview_builder
- custom_outlined_button
- custom_progress_widget
- custom_switch_list_tile
- custom_tab_bar_view
- expandable_text
- image_full_screen_wrapper
- not_found
- progress_controller
- restartable_circular_progress_indicator

## Getting started

This package uses intl, sizer. But you don't need to add them in your app. These are already present in this package.

You must wrap your MaterialApp with Sizer as follows

```dart
    class _MyAppState extends State<MyApp> {
      @override
      Widget build(BuildContext context) {
        return Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return MaterialApp(
                ....
            );
          },
        );
      }
    }
```

## Additional information

For more information contact [MicroProgramers](https://microprogramers.com)

## Connect with Developer
 Mubashar Hussain
 - [Facebook](https://facebook.com/MicroProgramer)
 - [YouTube](https://youtube.com/CSWorlds)
 - [Twitter](https://twitter.com/MicroProgramer)
 - [Instagram](https://instagram.com/MicroProgramer)

