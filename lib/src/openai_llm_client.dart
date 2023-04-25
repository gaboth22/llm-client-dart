import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:llm_client/src/llm_client.dart';

/// Open AI LLM client, providing ChatGPT-like functionality with a function
/// call
class OpenAiLlmClient implements LlmClient {
  /// Constructor
  /// apiKey is the OpenAI API key
  /// model is the name of the model to use
  /// temperature is a value between 0 and 2. Higher values like 0.8 will make
  /// the output more random, while lower values like 0.2 will make it more
  /// focused and deterministic
  OpenAiLlmClient(
    this.apiKey, {
    this.model = 'gpt-3.5-turbo',
    this.temperature = 0.5,
  });

  /// The API key for the OpenAI API
  String apiKey;

  /// The name of the model to use
  String model;

  /// Value between 0 and 2. Higher values like 0.8 will make the output more
  /// random, while lower values like 0.2 will make it more focused and
  /// deterministic
  double temperature;

  @override
  Future<String> getCompletion({
    required List<LlmClientMessage> messages,
  }) async {
    final url = Uri.https('api.openai.com', 'v1/chat/completions');
    final auth = 'Bearer $apiKey';
    final responseFuture = http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': auth},
      body: jsonEncode(
        {
          'model': model,
          'messages': messages.map((e) => e.toJson()).toList(),
          'temperature': temperature
        },
      ),
    );

    final completer = Completer<String>();

    unawaited(
      responseFuture.then(
        (http.Response response) => {
          if (response.statusCode != 200)
            {
              completer.complete(
                Future.error(
                  Exception(
                    'Request failed with: \n[HTTP '
                    '${response.statusCode}] ${response.body}',
                  ),
                ),
              ),
            }
          else
            {
              completer.complete(
                (((((jsonDecode(utf8.decode(response.bodyBytes))
                            as Map)['choices'] as List<dynamic>)[0]
                        as Map)['message'] as Map)['content'] as String)
                    .replaceAll('\n', ' '),
              ),
            }
        },
      ),
    );

    return completer.future;
  }
}
