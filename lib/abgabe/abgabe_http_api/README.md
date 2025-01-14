# abgabe_http_api

An empty Aqueduct application.

This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 0.0.1
- Build package: org.openapitools.codegen.languages.DartDioClientCodegen

## Requirements

Dart 1.20.0 or later OR Flutter 0.0.20 or later

## Installation & Usage

### Github

If this Dart package is published to Github, please include the following in pubspec.yaml
```
name: abgabe_http_api
version: 1.0.0
description: OpenAPI API client
dependencies:
  abgabe_http_api:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
      version: 'any'
```

### Local

To use the package in your local drive, please include the following in pubspec.yaml
```
dependencies:
  abgabe_http_api:
    path: /path/to/abgabe_http_api
```

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:abgabe_http_api/api.dart';


var api_instance = new AbgabeApi();
var id = id_example; // String | 
var submissionDto = new SubmissionDto(); // SubmissionDto | 

try {
    api_instance.publishSubmission(id, submissionDto);
} catch (e) {
    print("Exception when calling AbgabeApi->publishSubmission: $e\n");
}

```

## Documentation for API Endpoints

All URIs are relative to *https://api.sharezone.net*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*AbgabeApi* | [**publishSubmission**](doc//AbgabeApi.md#publishsubmission) | **patch** /v1/submissions/{id} | 
*AbgabedateiApi* | [**addFile**](doc//AbgabedateiApi.md#addfile) | **post** /v1/submissions/{submissionId}/files | 
*AbgabedateiApi* | [**deleteFile**](doc//AbgabedateiApi.md#deletefile) | **delete** /v1/submissions/{submissionId}/files/{fileId} | 
*AbgabedateiApi* | [**renameFile**](doc//AbgabedateiApi.md#renamefile) | **post** /v1/submissions/{submissionId}/files/{fileId} | 
*AbgabedateienApi* | [**addFiles**](doc//AbgabedateienApi.md#addfiles) | **post** /v1/submissions/{submissionId}/files/addList | 


## Documentation For Models

 - [DateiHinzufuegenCommandDto](doc//DateiHinzufuegenCommandDto.md)
 - [DateiHinzufuegenCommandDto1](doc//DateiHinzufuegenCommandDto1.md)
 - [DateienHinzufuegenCommandDto](doc//DateienHinzufuegenCommandDto.md)
 - [DateinameDto](doc//DateinameDto.md)
 - [InlineResponse400](doc//InlineResponse400.md)
 - [InlineResponse403](doc//InlineResponse403.md)
 - [SubmissionDto](doc//SubmissionDto.md)


## Documentation For Authorization

 All endpoints do not require authorization.
