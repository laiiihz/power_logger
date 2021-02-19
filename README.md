# power_logger

A well log tool on flutter, support Dio and custom type data.

## Getting Started

### Usage

* init logger

```dart
Future.delayed(
    Duration(milliseconds: 300),
    () => PowerLogger.init(context),
);
```

* add data to logger

```dart
LoggerData.addData(data);
```

## WARNING

*only tested on flutter 1.22.5

## author

[laiiihz](https://github.com/laiiihz)
