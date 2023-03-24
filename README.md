# Llm Client

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Basic LLM client, providing ChatGCP-like functionality with a function call.

### Example
```dart
import 'package:llm_client/llm_client.dart';

var llmClient = OpenAiLlmClient("MY_API_KEY"); // Replace API key
var query = """
Hello there. How are you?
""";
var response = await llmClient.getCompletion(query);
print(response);
```

## Installation 💻

**❗ In order to start using Llm Client you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `llm_client` to your `pubspec.yaml`:

```yaml
dependencies:
  llm_client: ^0.0.1
```

Install it:

```sh
dart pub get
```

---

## Running Tests 🧪

To run all unit tests:

```sh
dart test
```

[dart_install_link]: https://dart.dev/get-dart
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
