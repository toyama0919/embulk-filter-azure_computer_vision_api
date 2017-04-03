# Azure Computer Vision Api filter plugin for Embulk
[![Gem Version](https://badge.fury.io/rb/embulk-filter-azure_computer_vision_api.svg)](http://badge.fury.io/rb/embulk-filter-azure_computer_vision_api)

## Overview

* **Plugin type**: filter

## Configuration

- **api_type**: api_type(string, required)
- **out_key_name**: out_key_name(string, required)
- **image_path_key_name**: image_path_key_name(string, required)
- **params**: params(hash, default: {})
- **delay**: delay(integer, default: 0)
- **retry_wait**: retry_wait(integer, default: 10)
- **subscription_key**: subscription_key(string, required)

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

## Reference
[Computer Vision—Image Processing and Analytics \| Microsoft Azure](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/)
[Microsoft Cognitive Services \- Documentation](https://www.microsoft.com/cognitive-services/en-us/computer-vision-api/documentation)
[Cognitive Services APIs Reference](https://westus.dev.cognitive.microsoft.com/docs/services/56f91f2d778daf23d8ec6739/operations/56f91f2e778daf14a499e1fa)

## Build

```
$ rake
```
