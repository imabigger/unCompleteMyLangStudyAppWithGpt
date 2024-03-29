
import 'package:audioplayers/audioplayers.dart';

AudioPlayer globalAudioPlayer = AudioPlayer();

const voicenameTolangcountry = {
  "af-ZA-Standard-A (FEMALE)": "Afrikaans (South Africa)",
  "ar-XA-Standard-A (FEMALE)": "Arabic",
  "ar-XA-Standard-B (MALE)": "Arabic",
  "ar-XA-Standard-C (MALE)": "Arabic",
  "ar-XA-Standard-D (FEMALE)": "Arabic",
  "ar-XA-Wavenet-A (FEMALE)": "Arabic",
  "ar-XA-Wavenet-B (MALE)": "Arabic",
  "ar-XA-Wavenet-C (MALE)": "Arabic",
  "ar-XA-Wavenet-D (FEMALE)": "Arabic",
  "eu-ES-Standard-A (FEMALE)": "Basque (Spain)",
  "bn-IN-Standard-A (FEMALE)": "Bengali (India)",
  "bn-IN-Standard-B (MALE)": "Bengali (India)",
  "bn-IN-Wavenet-A (FEMALE)": "Bengali (India)",
  "bn-IN-Wavenet-B (MALE)": "Bengali (India)",
  "bg-BG-Standard-A (FEMALE)": "Bulgarian (Bulgaria)",
  "ca-ES-Standard-A (FEMALE)": "Catalan (Spain)",
  "yue-HK-Standard-A (FEMALE)": "Chinese (Hong Kong)",
  "yue-HK-Standard-B (MALE)": "Chinese (Hong Kong)",
  "yue-HK-Standard-C (FEMALE)": "Chinese (Hong Kong)",
  "yue-HK-Standard-D (MALE)": "Chinese (Hong Kong)",
  "cs-CZ-Standard-A (FEMALE)": "Czech (Czech Republic)",
  "cs-CZ-Wavenet-A (FEMALE)": "Czech (Czech Republic)",
  "da-DK-Neural2-D (FEMALE)": "Danish (Denmark)",
  "da-DK-Standard-A (FEMALE)": "Danish (Denmark)",
  "da-DK-Standard-C (MALE)": "Danish (Denmark)",
  "da-DK-Standard-D (FEMALE)": "Danish (Denmark)",
  "da-DK-Standard-E (FEMALE)": "Danish (Denmark)",
  "da-DK-Wavenet-A (FEMALE)": "Danish (Denmark)",
  "da-DK-Wavenet-C (MALE)": "Danish (Denmark)",
  "da-DK-Wavenet-D (FEMALE)": "Danish (Denmark)",
  "da-DK-Wavenet-E (FEMALE)": "Danish (Denmark)",
  "nl-BE-Standard-A (FEMALE)": "Dutch (Belgium)",
  "nl-BE-Standard-B (MALE)": "Dutch (Belgium)",
  "nl-BE-Wavenet-A (FEMALE)": "Dutch (Belgium)",
  "nl-BE-Wavenet-B (MALE)": "Dutch (Belgium)",
  "nl-NL-Standard-A (FEMALE)": "Dutch (Netherlands)",
  "nl-NL-Standard-B (MALE)": "Dutch (Netherlands)",
  "nl-NL-Standard-C (MALE)": "Dutch (Netherlands)",
  "nl-NL-Standard-D (FEMALE)": "Dutch (Netherlands)",
  "nl-NL-Standard-E (FEMALE)": "Dutch (Netherlands)",
  "nl-NL-Wavenet-A (FEMALE)": "Dutch (Netherlands)",
  "nl-NL-Wavenet-B (MALE)": "Dutch (Netherlands)",
  "nl-NL-Wavenet-C (MALE)": "Dutch (Netherlands)",
  "nl-NL-Wavenet-D (FEMALE)": "Dutch (Netherlands)",
  "nl-NL-Wavenet-E (FEMALE)": "Dutch (Netherlands)",
  "en-AU-Neural2-A (FEMALE)": "English (Australia)",
  "en-AU-Neural2-B (MALE)": "English (Australia)",
  "en-AU-Neural2-C (FEMALE)": "English (Australia)",
  "en-AU-Neural2-D (MALE)": "English (Australia)",
  "en-AU-News-E (FEMALE)": "English (Australia)",
  "en-AU-News-F (FEMALE)": "English (Australia)",
  "en-AU-News-G (MALE)": "English (Australia)",
  "en-AU-Polyglot-1 (MALE)": "English (Australia)",
  "en-AU-Standard-A (FEMALE)": "English (Australia)",
  "en-AU-Standard-B (MALE)": "English (Australia)",
  "en-AU-Standard-C (FEMALE)": "English (Australia)",
  "en-AU-Standard-D (MALE)": "English (Australia)",
  "en-AU-Wavenet-A (FEMALE)": "English (Australia)",
  "en-AU-Wavenet-B (MALE)": "English (Australia)",
  "en-AU-Wavenet-C (FEMALE)": "English (Australia)",
  "en-AU-Wavenet-D (MALE)": "English (Australia)",
  "en-IN-Standard-A (FEMALE)": "English (India)",
  "en-IN-Standard-B (MALE)": "English (India)",
  "en-IN-Standard-C (MALE)": "English (India)",
  "en-IN-Standard-D (FEMALE)": "English (India)",
  "en-IN-Wavenet-A (FEMALE)": "English (India)",
  "en-IN-Wavenet-B (MALE)": "English (India)",
  "en-IN-Wavenet-C (MALE)": "English (India)",
  "en-IN-Wavenet-D (FEMALE)": "English (India)",
  "en-GB-Neural2-A (FEMALE)": "English (UK)",
  "en-GB-Neural2-B (MALE)": "English (UK)",
  "en-GB-Neural2-C (FEMALE)": "English (UK)",
  "en-GB-Neural2-D (MALE)": "English (UK)",
  "en-GB-Neural2-F (FEMALE)": "English (UK)",
  "en-GB-News-G (FEMALE)": "English (UK)",
  "en-GB-News-H (FEMALE)": "English (UK)",
  "en-GB-News-I (FEMALE)": "English (UK)",
  "en-GB-News-J (MALE)": "English (UK)",
  "en-GB-News-K (MALE)": "English (UK)",
  "en-GB-News-L (MALE)": "English (UK)",
  "en-GB-News-M (MALE)": "English (UK)",
  "en-GB-Standard-A (FEMALE)": "English (UK)",
  "en-GB-Standard-B (MALE)": "English (UK)",
  "en-GB-Standard-C (FEMALE)": "English (UK)",
  "en-GB-Standard-D (MALE)": "English (UK)",
  "en-GB-Standard-F (FEMALE)": "English (UK)",
  "en-GB-Wavenet-A (FEMALE)": "English (UK)",
  "en-GB-Wavenet-B (MALE)": "English (UK)",
  "en-GB-Wavenet-C (FEMALE)": "English (UK)",
  "en-GB-Wavenet-D (MALE)": "English (UK)",
  "en-GB-Wavenet-F (FEMALE)": "English (UK)",
  "en-US-Neural2-A (MALE)": "English (US)",
  "en-US-Neural2-C (FEMALE)": "English (US)",
  "en-US-Neural2-D (MALE)": "English (US)",
  "en-US-Neural2-E (FEMALE)": "English (US)",
  "en-US-Neural2-F (FEMALE)": "English (US)",
  "en-US-Neural2-G (FEMALE)": "English (US)",
  "en-US-Neural2-H (FEMALE)": "English (US)",
  "en-US-Neural2-I (MALE)": "English (US)",
  "en-US-Neural2-J (MALE)": "English (US)",
  "en-US-News-K (FEMALE)": "English (US)",
  "en-US-News-L (FEMALE)": "English (US)",
  "en-US-News-M (MALE)": "English (US)",
  "en-US-News-N (MALE)": "English (US)",
  "en-US-Polyglot-1 (MALE)": "English (US)",
  "en-US-Standard-A (MALE)": "English (US)",
  "en-US-Standard-B (MALE)": "English (US)",
  "en-US-Standard-C (FEMALE)": "English (US)",
  "en-US-Standard-D (MALE)": "English (US)",
  "en-US-Standard-E (FEMALE)": "English (US)",
  "en-US-Standard-F (FEMALE)": "English (US)",
  "en-US-Standard-G (FEMALE)": "English (US)",
  "en-US-Standard-H (FEMALE)": "English (US)",
  "en-US-Standard-I (MALE)": "English (US)",
  "en-US-Standard-J (MALE)": "English (US)",
  "en-US-Studio-M (MALE)": "English (US)",
  "en-US-Studio-O (FEMALE)": "English (US)",
  "en-US-Wavenet-A (MALE)": "English (US)",
  "en-US-Wavenet-B (MALE)": "English (US)",
  "en-US-Wavenet-C (FEMALE)": "English (US)",
  "en-US-Wavenet-D (MALE)": "English (US)",
  "en-US-Wavenet-E (FEMALE)": "English (US)",
  "en-US-Wavenet-F (FEMALE)": "English (US)",
  "en-US-Wavenet-G (FEMALE)": "English (US)",
  "en-US-Wavenet-H (FEMALE)": "English (US)",
  "en-US-Wavenet-I (MALE)": "English (US)",
  "en-US-Wavenet-J (MALE)": "English (US)",
  "fil-PH-Standard-A (FEMALE)": "Filipino (Philippines)",
  "fil-PH-Standard-B (FEMALE)": "Filipino (Philippines)",
  "fil-PH-Standard-C (MALE)": "Filipino (Philippines)",
  "fil-PH-Standard-D (MALE)": "Filipino (Philippines)",
  "fil-PH-Wavenet-A (FEMALE)": "Filipino (Philippines)",
  "fil-PH-Wavenet-B (FEMALE)": "Filipino (Philippines)",
  "fil-PH-Wavenet-C (MALE)": "Filipino (Philippines)",
  "fil-PH-Wavenet-D (MALE)": "Filipino (Philippines)",
  "fil-ph-Neural2-A (FEMALE)": "Filipino (Philippines)",
  "fil-ph-Neural2-D (MALE)": "Filipino (Philippines)",
  "fi-FI-Standard-A (FEMALE)": "Finnish (Finland)",
  "fi-FI-Wavenet-A (FEMALE)": "Finnish (Finland)",
  "fr-CA-Neural2-A (FEMALE)": "French (Canada)",
  "fr-CA-Neural2-B (MALE)": "French (Canada)",
  "fr-CA-Neural2-C (FEMALE)": "French (Canada)",
  "fr-CA-Neural2-D (MALE)": "French (Canada)",
  "fr-CA-Standard-A (FEMALE)": "French (Canada)",
  "fr-CA-Standard-B (MALE)": "French (Canada)",
  "fr-CA-Standard-C (FEMALE)": "French (Canada)",
  "fr-CA-Standard-D (MALE)": "French (Canada)",
  "fr-CA-Wavenet-A (FEMALE)": "French (Canada)",
  "fr-CA-Wavenet-B (MALE)": "French (Canada)",
  "fr-CA-Wavenet-C (FEMALE)": "French (Canada)",
  "fr-CA-Wavenet-D (MALE)": "French (Canada)",
  "fr-FR-Neural2-A (FEMALE)": "French (France)",
  "fr-FR-Neural2-B (MALE)": "French (France)",
  "fr-FR-Neural2-C (FEMALE)": "French (France)",
  "fr-FR-Neural2-D (MALE)": "French (France)",
  "fr-FR-Neural2-E (FEMALE)": "French (France)",
  "fr-FR-Polyglot-1 (MALE)": "French (France)",
  "fr-FR-Standard-A (FEMALE)": "French (France)",
  "fr-FR-Standard-B (MALE)": "French (France)",
  "fr-FR-Standard-C (FEMALE)": "French (France)",
  "fr-FR-Standard-D (MALE)": "French (France)",
  "fr-FR-Standard-E (FEMALE)": "French (France)",
  "fr-FR-Wavenet-A (FEMALE)": "French (France)",
  "fr-FR-Wavenet-B (MALE)": "French (France)",
  "fr-FR-Wavenet-C (FEMALE)": "French (France)",
  "fr-FR-Wavenet-D (MALE)": "French (France)",
  "fr-FR-Wavenet-E (FEMALE)": "French (France)",
  "gl-ES-Standard-A (FEMALE)": "Galician (Spain)",
  "de-DE-Neural2-B (MALE)": "German (Germany)",
  "de-DE-Neural2-C (FEMALE)": "German (Germany)",
  "de-DE-Neural2-D (MALE)": "German (Germany)",
  "de-DE-Neural2-F (FEMALE)": "German (Germany)",
  "de-DE-Polyglot-1 (MALE)": "German (Germany)",
  "de-DE-Standard-A (FEMALE)": "German (Germany)",
  "de-DE-Standard-B (MALE)": "German (Germany)",
  "de-DE-Standard-C (FEMALE)": "German (Germany)",
  "de-DE-Standard-D (MALE)": "German (Germany)",
  "de-DE-Standard-E (MALE)": "German (Germany)",
  "de-DE-Standard-F (FEMALE)": "German (Germany)",
  "de-DE-Wavenet-A (FEMALE)": "German (Germany)",
  "de-DE-Wavenet-B (MALE)": "German (Germany)",
  "de-DE-Wavenet-C (FEMALE)": "German (Germany)",
  "de-DE-Wavenet-D (MALE)": "German (Germany)",
  "de-DE-Wavenet-E (MALE)": "German (Germany)",
  "de-DE-Wavenet-F (FEMALE)": "German (Germany)",
  "el-GR-Standard-A (FEMALE)": "Greek (Greece)",
  "el-GR-Wavenet-A (FEMALE)": "Greek (Greece)",
  "gu-IN-Standard-A (FEMALE)": "Gujarati (India)",
  "gu-IN-Standard-B (MALE)": "Gujarati (India)",
  "gu-IN-Wavenet-A (FEMALE)": "Gujarati (India)",
  "gu-IN-Wavenet-B (MALE)": "Gujarati (India)",
  "he-IL-Standard-A (FEMALE)": "Hebrew (Israel)",
  "he-IL-Standard-B (MALE)": "Hebrew (Israel)",
  "he-IL-Standard-C (FEMALE)": "Hebrew (Israel)",
  "he-IL-Standard-D (MALE)": "Hebrew (Israel)",
  "he-IL-Wavenet-A (FEMALE)": "Hebrew (Israel)",
  "he-IL-Wavenet-B (MALE)": "Hebrew (Israel)",
  "he-IL-Wavenet-C (FEMALE)": "Hebrew (Israel)",
  "he-IL-Wavenet-D (MALE)": "Hebrew (Israel)",
  "hi-IN-Neural2-A (FEMALE)": "Hindi (India)",
  "hi-IN-Neural2-B (MALE)": "Hindi (India)",
  "hi-IN-Neural2-C (MALE)": "Hindi (India)",
  "hi-IN-Neural2-D (FEMALE)": "Hindi (India)",
  "hi-IN-Standard-A (FEMALE)": "Hindi (India)",
  "hi-IN-Standard-B (MALE)": "Hindi (India)",
  "hi-IN-Standard-C (MALE)": "Hindi (India)",
  "hi-IN-Standard-D (FEMALE)": "Hindi (India)",
  "hi-IN-Wavenet-A (FEMALE)": "Hindi (India)",
  "hi-IN-Wavenet-B (MALE)": "Hindi (India)",
  "hi-IN-Wavenet-C (MALE)": "Hindi (India)",
  "hi-IN-Wavenet-D (FEMALE)": "Hindi (India)",
  "hu-HU-Standard-A (FEMALE)": "Hungarian (Hungary)",
  "hu-HU-Wavenet-A (FEMALE)": "Hungarian (Hungary)",
  "is-IS-Standard-A (FEMALE)": "Icelandic (Iceland)",
  "id-ID-Standard-A (FEMALE)": "Indonesian (Indonesia)",
  "id-ID-Standard-B (MALE)": "Indonesian (Indonesia)",
  "id-ID-Standard-C (MALE)": "Indonesian (Indonesia)",
  "id-ID-Standard-D (FEMALE)": "Indonesian (Indonesia)",
  "id-ID-Wavenet-A (FEMALE)": "Indonesian (Indonesia)",
  "id-ID-Wavenet-B (MALE)": "Indonesian (Indonesia)",
  "id-ID-Wavenet-C (MALE)": "Indonesian (Indonesia)",
  "id-ID-Wavenet-D (FEMALE)": "Indonesian (Indonesia)",
  "it-IT-Neural2-A (FEMALE)": "Italian (Italy)",
  "it-IT-Neural2-C (MALE)": "Italian (Italy)",
  "it-IT-Standard-A (FEMALE)": "Italian (Italy)",
  "it-IT-Standard-B (FEMALE)": "Italian (Italy)",
  "it-IT-Standard-C (MALE)": "Italian (Italy)",
  "it-IT-Standard-D (MALE)": "Italian (Italy)",
  "it-IT-Wavenet-A (FEMALE)": "Italian (Italy)",
  "it-IT-Wavenet-B (FEMALE)": "Italian (Italy)",
  "it-IT-Wavenet-C (MALE)": "Italian (Italy)",
  "it-IT-Wavenet-D (MALE)": "Italian (Italy)",
  "ja-JP-Neural2-B (FEMALE)": "Japanese (Japan)",
  "ja-JP-Neural2-C (MALE)": "Japanese (Japan)",
  "ja-JP-Neural2-D (MALE)": "Japanese (Japan)",
  "ja-JP-Standard-A (FEMALE)": "Japanese (Japan)",
  "ja-JP-Standard-B (FEMALE)": "Japanese (Japan)",
  "ja-JP-Standard-C (MALE)": "Japanese (Japan)",
  "ja-JP-Standard-D (MALE)": "Japanese (Japan)",
  "ja-JP-Wavenet-A (FEMALE)": "Japanese (Japan)",
  "ja-JP-Wavenet-B (FEMALE)": "Japanese (Japan)",
  "ja-JP-Wavenet-C (MALE)": "Japanese (Japan)",
  "ja-JP-Wavenet-D (MALE)": "Japanese (Japan)",
  "kn-IN-Standard-A (FEMALE)": "Kannada (India)",
  "kn-IN-Standard-B (MALE)": "Kannada (India)",
  "kn-IN-Wavenet-A (FEMALE)": "Kannada (India)",
  "kn-IN-Wavenet-B (MALE)": "Kannada (India)",
  "ko-KR-Neural2-A (FEMALE)": "Korean (South Korea)",
  "ko-KR-Neural2-B (FEMALE)": "Korean (South Korea)",
  "ko-KR-Neural2-C (MALE)": "Korean (South Korea)",
  "ko-KR-Standard-A (FEMALE)": "Korean (South Korea)",
  "ko-KR-Standard-B (FEMALE)": "Korean (South Korea)",
  "ko-KR-Standard-C (MALE)": "Korean (South Korea)",
  "ko-KR-Standard-D (MALE)": "Korean (South Korea)",
  "ko-KR-Wavenet-A (FEMALE)": "Korean (South Korea)",
  "ko-KR-Wavenet-B (FEMALE)": "Korean (South Korea)",
  "ko-KR-Wavenet-C (MALE)": "Korean (South Korea)",
  "ko-KR-Wavenet-D (MALE)": "Korean (South Korea)",
  "lv-LV-Standard-A (MALE)": "Latvian (Latvia)",
  "lt-LT-Standard-A (MALE)": "Lithuanian (Lithuania)",
  "ms-MY-Standard-A (FEMALE)": "Malay (Malaysia)",
  "ms-MY-Standard-B (MALE)": "Malay (Malaysia)",
  "ms-MY-Standard-C (FEMALE)": "Malay (Malaysia)",
  "ms-MY-Standard-D (MALE)": "Malay (Malaysia)",
  "ms-MY-Wavenet-A (FEMALE)": "Malay (Malaysia)",
  "ms-MY-Wavenet-B (MALE)": "Malay (Malaysia)",
  "ms-MY-Wavenet-C (FEMALE)": "Malay (Malaysia)",
  "ms-MY-Wavenet-D (MALE)": "Malay (Malaysia)",
  "ml-IN-Standard-A (FEMALE)": "Malayalam (India)",
  "ml-IN-Standard-B (MALE)": "Malayalam (India)",
  "ml-IN-Wavenet-A (FEMALE)": "Malayalam (India)",
  "ml-IN-Wavenet-B (MALE)": "Malayalam (India)",
  "ml-IN-Wavenet-C (FEMALE)": "Malayalam (India)",
  "ml-IN-Wavenet-D (MALE)": "Malayalam (India)",
  "cmn-CN-Standard-A (FEMALE)": "Mandarin Chinese",
  "cmn-CN-Standard-B (MALE)": "Mandarin Chinese",
  "cmn-CN-Standard-C (MALE)": "Mandarin Chinese",
  "cmn-CN-Standard-D (FEMALE)": "Mandarin Chinese",
  "cmn-CN-Wavenet-A (FEMALE)": "Mandarin Chinese",
  "cmn-CN-Wavenet-B (MALE)": "Mandarin Chinese",
  "cmn-CN-Wavenet-C (MALE)": "Mandarin Chinese",
  "cmn-CN-Wavenet-D (FEMALE)": "Mandarin Chinese",
  "cmn-TW-Standard-A (FEMALE)": "Mandarin Chinese",
  "cmn-TW-Standard-B (MALE)": "Mandarin Chinese",
  "cmn-TW-Standard-C (MALE)": "Mandarin Chinese",
  "cmn-TW-Wavenet-A (FEMALE)": "Mandarin Chinese",
  "cmn-TW-Wavenet-B (MALE)": "Mandarin Chinese",
  "cmn-TW-Wavenet-C (MALE)": "Mandarin Chinese",
  "mr-IN-Standard-A (FEMALE)": "Marathi (India)",
  "mr-IN-Standard-B (MALE)": "Marathi (India)",
  "mr-IN-Standard-C (FEMALE)": "Marathi (India)",
  "mr-IN-Wavenet-A (FEMALE)": "Marathi (India)",
  "mr-IN-Wavenet-B (MALE)": "Marathi (India)",
  "mr-IN-Wavenet-C (FEMALE)": "Marathi (India)",
  "nb-NO-Standard-A (FEMALE)": "Norwegian (Norway)",
  "nb-NO-Standard-B (MALE)": "Norwegian (Norway)",
  "nb-NO-Standard-C (FEMALE)": "Norwegian (Norway)",
  "nb-NO-Standard-D (MALE)": "Norwegian (Norway)",
  "nb-NO-Standard-E (FEMALE)": "Norwegian (Norway)",
  "nb-NO-Wavenet-A (FEMALE)": "Norwegian (Norway)",
  "nb-NO-Wavenet-B (MALE)": "Norwegian (Norway)",
  "nb-NO-Wavenet-C (FEMALE)": "Norwegian (Norway)",
  "nb-NO-Wavenet-D (MALE)": "Norwegian (Norway)",
  "nb-NO-Wavenet-E (FEMALE)": "Norwegian (Norway)",
  "pl-PL-Standard-A (FEMALE)": "Polish (Poland)",
  "pl-PL-Standard-B (MALE)": "Polish (Poland)",
  "pl-PL-Standard-C (MALE)": "Polish (Poland)",
  "pl-PL-Standard-D (FEMALE)": "Polish (Poland)",
  "pl-PL-Standard-E (FEMALE)": "Polish (Poland)",
  "pl-PL-Wavenet-A (FEMALE)": "Polish (Poland)",
  "pl-PL-Wavenet-B (MALE)": "Polish (Poland)",
  "pl-PL-Wavenet-C (MALE)": "Polish (Poland)",
  "pl-PL-Wavenet-D (FEMALE)": "Polish (Poland)",
  "pl-PL-Wavenet-E (FEMALE)": "Polish (Poland)",
  "pt-BR-Neural2-A (FEMALE)": "Portuguese (Brazil)",
  "pt-BR-Neural2-B (MALE)": "Portuguese (Brazil)",
  "pt-BR-Neural2-C (FEMALE)": "Portuguese (Brazil)",
  "pt-BR-Standard-A (FEMALE)": "Portuguese (Brazil)",
  "pt-BR-Standard-B (MALE)": "Portuguese (Brazil)",
  "pt-BR-Standard-C (FEMALE)": "Portuguese (Brazil)",
  "pt-BR-Wavenet-A (FEMALE)": "Portuguese (Brazil)",
  "pt-BR-Wavenet-B (MALE)": "Portuguese (Brazil)",
  "pt-BR-Wavenet-C (FEMALE)": "Portuguese (Brazil)",
  "pt-PT-Standard-A (FEMALE)": "Portuguese (Portugal)",
  "pt-PT-Standard-B (MALE)": "Portuguese (Portugal)",
  "pt-PT-Standard-C (MALE)": "Portuguese (Portugal)",
  "pt-PT-Standard-D (FEMALE)": "Portuguese (Portugal)",
  "pt-PT-Wavenet-A (FEMALE)": "Portuguese (Portugal)",
  "pt-PT-Wavenet-B (MALE)": "Portuguese (Portugal)",
  "pt-PT-Wavenet-C (MALE)": "Portuguese (Portugal)",
  "pt-PT-Wavenet-D (FEMALE)": "Portuguese (Portugal)",
  "pa-IN-Standard-A (FEMALE)": "Punjabi (India)",
  "pa-IN-Standard-B (MALE)": "Punjabi (India)",
  "pa-IN-Standard-C (FEMALE)": "Punjabi (India)",
  "pa-IN-Standard-D (MALE)": "Punjabi (India)",
  "pa-IN-Wavenet-A (FEMALE)": "Punjabi (India)",
  "pa-IN-Wavenet-B (MALE)": "Punjabi (India)",
  "pa-IN-Wavenet-C (FEMALE)": "Punjabi (India)",
  "pa-IN-Wavenet-D (MALE)": "Punjabi (India)",
  "ro-RO-Standard-A (FEMALE)": "Romanian (Romania)",
  "ro-RO-Wavenet-A (FEMALE)": "Romanian (Romania)",
  "ru-RU-Standard-A (FEMALE)": "Russian (Russia)",
  "ru-RU-Standard-B (MALE)": "Russian (Russia)",
  "ru-RU-Standard-C (FEMALE)": "Russian (Russia)",
  "ru-RU-Standard-D (MALE)": "Russian (Russia)",
  "ru-RU-Standard-E (FEMALE)": "Russian (Russia)",
  "ru-RU-Wavenet-A (FEMALE)": "Russian (Russia)",
  "ru-RU-Wavenet-B (MALE)": "Russian (Russia)",
  "ru-RU-Wavenet-C (FEMALE)": "Russian (Russia)",
  "ru-RU-Wavenet-D (MALE)": "Russian (Russia)",
  "ru-RU-Wavenet-E (FEMALE)": "Russian (Russia)",
  "sr-RS-Standard-A (FEMALE)": "Serbian (Cyrillic)",
  "sk-SK-Standard-A (FEMALE)": "Slovak (Slovakia)",
  "sk-SK-Wavenet-A (FEMALE)": "Slovak (Slovakia)",
  "es-ES-Neural2-A (FEMALE)": "Spanish (Spain)",
  "es-ES-Neural2-B (MALE)": "Spanish (Spain)",
  "es-ES-Neural2-C (FEMALE)": "Spanish (Spain)",
  "es-ES-Neural2-D (FEMALE)": "Spanish (Spain)",
  "es-ES-Neural2-E (FEMALE)": "Spanish (Spain)",
  "es-ES-Neural2-F (MALE)": "Spanish (Spain)",
  "es-ES-Polyglot-1 (MALE)": "Spanish (Spain)",
  "es-ES-Standard-A (FEMALE)": "Spanish (Spain)",
  "es-ES-Standard-B (MALE)": "Spanish (Spain)",
  "es-ES-Standard-C (FEMALE)": "Spanish (Spain)",
  "es-ES-Standard-D (FEMALE)": "Spanish (Spain)",
  "es-ES-Wavenet-B (MALE)": "Spanish (Spain)",
  "es-ES-Wavenet-C (FEMALE)": "Spanish (Spain)",
  "es-ES-Wavenet-D (FEMALE)": "Spanish (Spain)",
  "es-US-Neural2-A (FEMALE)": "Spanish (US)",
  "es-US-Neural2-B (MALE)": "Spanish (US)",
  "es-US-Neural2-C (MALE)": "Spanish (US)",
  "es-US-News-D (MALE)": "Spanish (US)",
  "es-US-News-E (MALE)": "Spanish (US)",
  "es-US-News-F (FEMALE)": "Spanish (US)",
  "es-US-News-G (FEMALE)": "Spanish (US)",
  "es-US-Polyglot-1 (MALE)": "Spanish (US)",
  "es-US-Standard-A (FEMALE)": "Spanish (US)",
  "es-US-Standard-B (MALE)": "Spanish (US)",
  "es-US-Standard-C (MALE)": "Spanish (US)",
  "es-US-Studio-B (MALE)": "Spanish (US)",
  "es-US-Wavenet-A (FEMALE)": "Spanish (US)",
  "es-US-Wavenet-B (MALE)": "Spanish (US)",
  "es-US-Wavenet-C (MALE)": "Spanish (US)",
  "sv-SE-Standard-A (FEMALE)": "Swedish (Sweden)",
  "sv-SE-Standard-B (FEMALE)": "Swedish (Sweden)",
  "sv-SE-Standard-C (FEMALE)": "Swedish (Sweden)",
  "sv-SE-Standard-D (MALE)": "Swedish (Sweden)",
  "sv-SE-Standard-E (MALE)": "Swedish (Sweden)",
  "sv-SE-Wavenet-A (FEMALE)": "Swedish (Sweden)",
  "sv-SE-Wavenet-B (FEMALE)": "Swedish (Sweden)",
  "sv-SE-Wavenet-C (MALE)": "Swedish (Sweden)",
  "sv-SE-Wavenet-D (FEMALE)": "Swedish (Sweden)",
  "sv-SE-Wavenet-E (MALE)": "Swedish (Sweden)",
  "ta-IN-Standard-A (FEMALE)": "Tamil (India)",
  "ta-IN-Standard-B (MALE)": "Tamil (India)",
  "ta-IN-Standard-C (FEMALE)": "Tamil (India)",
  "ta-IN-Standard-D (MALE)": "Tamil (India)",
  "ta-IN-Wavenet-A (FEMALE)": "Tamil (India)",
  "ta-IN-Wavenet-B (MALE)": "Tamil (India)",
  "ta-IN-Wavenet-C (FEMALE)": "Tamil (India)",
  "ta-IN-Wavenet-D (MALE)": "Tamil (India)",
  "te-IN-Standard-A (FEMALE)": "Telugu (India)",
  "te-IN-Standard-B (MALE)": "Telugu (India)",
  "th-TH-Neural2-C (FEMALE)": "Thai (Thailand)",
  "th-TH-Standard-A (FEMALE)": "Thai (Thailand)",
  "tr-TR-Standard-A (FEMALE)": "Turkish (Turkey)",
  "tr-TR-Standard-B (MALE)": "Turkish (Turkey)",
  "tr-TR-Standard-C (FEMALE)": "Turkish (Turkey)",
  "tr-TR-Standard-D (FEMALE)": "Turkish (Turkey)",
  "tr-TR-Standard-E (MALE)": "Turkish (Turkey)",
  "tr-TR-Wavenet-A (FEMALE)": "Turkish (Turkey)",
  "tr-TR-Wavenet-B (MALE)": "Turkish (Turkey)",
  "tr-TR-Wavenet-C (FEMALE)": "Turkish (Turkey)",
  "tr-TR-Wavenet-D (FEMALE)": "Turkish (Turkey)",
  "tr-TR-Wavenet-E (MALE)": "Turkish (Turkey)",
  "uk-UA-Standard-A (FEMALE)": "Ukrainian (Ukraine)",
  "uk-UA-Wavenet-A (FEMALE)": "Ukrainian (Ukraine)",
  "vi-VN-Neural2-A (FEMALE)": "Vietnamese (Vietnam)",
  "vi-VN-Neural2-D (MALE)": "Vietnamese (Vietnam)",
  "vi-VN-Standard-A (FEMALE)": "Vietnamese (Vietnam)",
  "vi-VN-Standard-B (MALE)": "Vietnamese (Vietnam)",
  "vi-VN-Standard-C (FEMALE)": "Vietnamese (Vietnam)",
  "vi-VN-Standard-D (MALE)": "Vietnamese (Vietnam)",
  "vi-VN-Wavenet-A (FEMALE)": "Vietnamese (Vietnam)",
  "vi-VN-Wavenet-B (MALE)": "Vietnamese (Vietnam)",
  "vi-VN-Wavenet-C (FEMALE)": "Vietnamese (Vietnam)",
  "vi-VN-Wavenet-D (MALE)": "Vietnamese (Vietnam)"
};
