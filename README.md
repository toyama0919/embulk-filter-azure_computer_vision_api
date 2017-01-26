# Azure Computer Vision Api filter plugin for Embulk


## Overview

* **Plugin type**: filter

## Configuration

- **api_type**: api_type(string)
- **out_key_name**: out_key_name(string)
- **image_path_key_name**: image_path_key_name(string)
- **params**: params(hash, default: {})
- **delay**: delay(integer, default: 0)
- **retry_wait**: retry_wait(integer, default: 10)
- **subscription_key**: subscription_key(string)

## Example

```yaml
  - type: azure_computer_vision_api
    api_type: ocr
    image_path_key_name: image_path
    out_key_name: image_info
    # params:
    #   language: "ja"
    #   detectOrientation: true
    subscription_key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Build

```
$ rake
```
