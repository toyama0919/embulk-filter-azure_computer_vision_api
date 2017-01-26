# Azure Computer Vision Api filter plugin for Embulk

TODO: Write short description here and embulk-filter-azure_computer_vision_api.gemspec file.

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
filters:
  - type: azure_translator_api
    key_names:
      - english_column
      - chinese_column2
    out_key_name_suffix: _translated
    subscription_key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    api_type: Translate
    to: ja
```

## Build

```
$ rake
```
