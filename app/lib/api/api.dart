// Openapi Generator last run: : 2024-06-21T14:07:15.978390
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:api/api.dart' as generatedApi;

final String apiUrl = dotenv.env['API_URL']!;

@Openapi(
  inputSpec: RemoteSpec(
    path: "https://douchat-api.doggo-saloon.net/api-docs/openapi.json",
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