/// {@template llm_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class LlmClient {
  /// content is the input to pass to the model.
  /// This returns a future with the string response.
  Future<String> getCompletion(String content) async {
    return Future.value('');
  }
}
