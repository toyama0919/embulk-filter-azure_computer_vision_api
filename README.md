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

### OCR(text recognition)

```yaml
  - type: azure_computer_vision_api
    api_type: ocr
    image_path_key_name: {{ image_path_key_name }}
    out_key_name: azure_text
    params:
      language: "ja"
      detectOrientation: true
    subscription_key: {{ env.AZURE_COMPUTER_VISION_SUBSCRIPTION_KEY }}
```

### analyze(Categories,Tags,Description,Faces,ImageType,Color,Adult)

```yaml
  - type: azure_computer_vision_api
    api_type: analyze
    image_path_key_name: {{ image_path_key_name }}
    out_key_name: azure_analyze
    params:
      visualFeatures: "Categories,Tags,Description,Faces,ImageType,Color,Adult"
      language: en
    subscription_key: {{ env.AZURE_COMPUTER_VISION_SUBSCRIPTION_KEY }}
```

### tag

```yaml
  - type: azure_computer_vision_api
    api_type: tag
    image_path_key_name: {{ image_path_key_name }}
    out_key_name: azure_tag
    subscription_key: {{ env.AZURE_COMPUTER_VISION_SUBSCRIPTION_KEY }}
```

### describe

```yaml
  - type: azure_computer_vision_api
    api_type: describe
    image_path_key_name: {{ image_path_key_name }}
    out_key_name: azure_describe
    subscription_key: {{ env.AZURE_COMPUTER_VISION_SUBSCRIPTION_KEY }}
```

## Build

```
$ rake
```
