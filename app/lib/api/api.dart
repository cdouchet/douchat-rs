// Openapi Generator last run: : 2024-04-30T15:23:28.448314
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:api/api.dart' as generatedApi;

final String apiUrl = dotenv.env['API_URL']!;

@Openapi(
  inputSpec: RemoteSpec(
    path: 'https://douchat-test.doggo-saloon.net/api-docs/openapi.json',
  ),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'api',
  apiPackage: 'api',
  additionalProperties: AdditionalProperties(
    pubName: 'api',
  ),
)
class Api {}

final api = generatedApi.Api();