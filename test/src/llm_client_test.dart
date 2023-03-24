// ignore_for_file: prefer_const_constructors
import 'dart:io' show Platform;
import 'package:llm_client/llm_client.dart';
import 'package:llm_client/src/openai_llm_client.dart';
import 'package:test/test.dart';

void main() {
  group('LlmClient', () {
    test('can instantiate openai client', () {
      expect(OpenAiLlmClient(''), isNotNull);
    });

    test('can call remote openai client', () {
      final envVars = Platform.environment;
      // This test assumes that the environment variable OPEN_AI_API_KEY is set
      final apiKey = envVars['OPEN_AI_API_KEY'] ?? '';
      expect(apiKey, isNotEmpty);
      final client = OpenAiLlmClient(apiKey);

      final response = client.getCompletion('Hello there! How are you?')
        ..then((value) => expect(value, isNotEmpty));

      expect(response, completes);
    });

    test('should propagate error in openai client', () async {
      final client = OpenAiLlmClient('BAD_API_KEY');

      try {
        await client.getCompletion('Hello there! How are you?');
      } catch (e) {
        expect(e.toString(), isNotEmpty);
      }
    });
  });
}
