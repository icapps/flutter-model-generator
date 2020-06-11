# Model Generator

This model generator can be used to generate JsonSerializable models

[![pub package](https://img.shields.io/pub/v/model_generator.svg)](https://pub.dartlang.org/packages/model_generator)

Example of the `model_generator/config.yaml` file
```
UserModel:
  path: webservice/user
  properties:
    id:
      type: int
    name:
      type: string
    salary:
      type: double
    something:
      type: dynamic
    isLoggedIn:
      type: bool
    roles:
      type: array
      items:
        type: string
    addresses:
      type: array
      items:
        type: Address
    securityRole:
      type: string
      jsonKey: securityIndicator

Address:
  path: webservice/user
  properties:
    street:
      type: string
```

Support for Enums:

```
Gender:
  path: webservice/user
  type: enum
  properties:
    MALE:
      value: _mAl3
    FEMALE:
      value: femAle
    X:
      value: X
```

Run: 

`flutter packages run model_generator`