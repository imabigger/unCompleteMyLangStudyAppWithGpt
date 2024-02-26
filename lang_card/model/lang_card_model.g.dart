// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardModelAdapter extends TypeAdapter<CardModel> {
  @override
  final int typeId = 0;

  @override
  CardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardModel(
      baseString: fields[0] as String,
      cardUniqueId: fields[1] as String,
      baseLang: fields[2] as Lang,
      cardDirectory: fields[4] as String,
      makerId: fields[5] as String,
    )..langStorage = (fields[3] as List).cast<LangStorageModel>();
  }

  @override
  void write(BinaryWriter writer, CardModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.baseString)
      ..writeByte(1)
      ..write(obj.cardUniqueId)
      ..writeByte(2)
      ..write(obj.baseLang)
      ..writeByte(3)
      ..write(obj.langStorage)
      ..writeByte(4)
      ..write(obj.cardDirectory)
      ..writeByte(5)
      ..write(obj.makerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LangStorageModelAdapter extends TypeAdapter<LangStorageModel> {
  @override
  final int typeId = 1;

  @override
  LangStorageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LangStorageModel(
      language: fields[0] as Lang,
      transString: fields[1] as String,
    )..detailCards = (fields[2] as List).cast<CardDetailModel>();
  }

  @override
  void write(BinaryWriter writer, LangStorageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.language)
      ..writeByte(1)
      ..write(obj.transString)
      ..writeByte(2)
      ..write(obj.detailCards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LangStorageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardDetailModelAdapter extends TypeAdapter<CardDetailModel> {
  @override
  final int typeId = 2;

  @override
  CardDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDetailModel(
      unit: fields[0] as String,
      explain: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardDetailModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.unit)
      ..writeByte(1)
      ..write(obj.explain);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      baseString: json['baseString'] as String,
      cardUniqueId: json['cardUniqueId'] as String,
      baseLang: $enumDecode(_$LangEnumMap, json['baseLang']),
      cardDirectory: json['cardDirectory'] as String,
      makerId: json['makerId'] as String,
    )..langStorage = (json['langStorage'] as List<dynamic>)
        .map((e) => LangStorageModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'baseString': instance.baseString,
      'cardUniqueId': instance.cardUniqueId,
      'baseLang': _$LangEnumMap[instance.baseLang]!,
      'langStorage': instance.langStorage.map((e) => e.toJson()).toList(),
      'cardDirectory': instance.cardDirectory,
      'makerId': instance.makerId,
    };

const _$LangEnumMap = {
  Lang.Afrikaans: 'Afrikaans',
  Lang.Albanian: 'Albanian',
  Lang.Amharic: 'Amharic',
  Lang.Arabic: 'Arabic',
  Lang.Armenian: 'Armenian',
  Lang.Assamese: 'Assamese',
  Lang.Aymara: 'Aymara',
  Lang.Azerbaijani: 'Azerbaijani',
  Lang.Bambara: 'Bambara',
  Lang.Basque: 'Basque',
  Lang.Belarusian: 'Belarusian',
  Lang.Bengali: 'Bengali',
  Lang.Bhojpuri: 'Bhojpuri',
  Lang.Bosnian: 'Bosnian',
  Lang.Bulgarian: 'Bulgarian',
  Lang.BurmeseMyanmar: 'BurmeseMyanmar',
  Lang.Catalan: 'Catalan',
  Lang.Cebuano: 'Cebuano',
  Lang.Chewa: 'Chewa',
  Lang.Chinese: 'Chinese',
  Lang.ChineseSimplified: 'ChineseSimplified',
  Lang.ChineseTraditional: 'ChineseTraditional',
  Lang.Chonga: 'Chonga',
  Lang.Corsican: 'Corsican',
  Lang.Creole: 'Creole',
  Lang.Croatian: 'Croatian',
  Lang.Czech: 'Czech',
  Lang.Danish: 'Danish',
  Lang.Divehi: 'Divehi',
  Lang.Dogri: 'Dogri',
  Lang.Dutch: 'Dutch',
  Lang.English: 'English',
  Lang.Esperanto: 'Esperanto',
  Lang.Estonian: 'Estonian',
  Lang.Ewe: 'Ewe',
  Lang.Filipino: 'Filipino',
  Lang.Finnish: 'Finnish',
  Lang.French: 'French',
  Lang.Frisian: 'Frisian',
  Lang.Galician: 'Galician',
  Lang.Georgian: 'Georgian',
  Lang.German: 'German',
  Lang.Greek: 'Greek',
  Lang.Guarani: 'Guarani',
  Lang.Gujarati: 'Gujarati',
  Lang.HaitianCreole: 'HaitianCreole',
  Lang.Hausa: 'Hausa',
  Lang.Hawaiian: 'Hawaiian',
  Lang.Hebrew: 'Hebrew',
  Lang.Hindi: 'Hindi',
  Lang.Hmong: 'Hmong',
  Lang.Hungarian: 'Hungarian',
  Lang.Icelandic: 'Icelandic',
  Lang.Igbo: 'Igbo',
  Lang.Ilocano: 'Ilocano',
  Lang.Indonesian: 'Indonesian',
  Lang.Irish: 'Irish',
  Lang.Italian: 'Italian',
  Lang.Japanese: 'Japanese',
  Lang.Javanese: 'Javanese',
  Lang.Kannada: 'Kannada',
  Lang.Kazakh: 'Kazakh',
  Lang.Khmer: 'Khmer',
  Lang.Kinyarwanda: 'Kinyarwanda',
  Lang.Konkani: 'Konkani',
  Lang.Korean: 'Korean',
  Lang.Kurdish: 'Kurdish',
  Lang.Kyrgyz: 'Kyrgyz',
  Lang.Lao: 'Lao',
  Lang.Latin: 'Latin',
  Lang.Latvian: 'Latvian',
  Lang.Lingala: 'Lingala',
  Lang.Lithuanian: 'Lithuanian',
  Lang.Luganda: 'Luganda',
  Lang.Luxembourgish: 'Luxembourgish',
  Lang.Macedonian: 'Macedonian',
  Lang.Maithili: 'Maithili',
  Lang.Malagasy: 'Malagasy',
  Lang.Malay: 'Malay',
  Lang.Malayalam: 'Malayalam',
  Lang.Maltese: 'Maltese',
  Lang.Maori: 'Maori',
  Lang.Marathi: 'Marathi',
  Lang.MeiteiManipuri: 'MeiteiManipuri',
  Lang.Mizo: 'Mizo',
  Lang.Mongolian: 'Mongolian',
  Lang.Nepali: 'Nepali',
  Lang.NorthernSotho: 'NorthernSotho',
  Lang.Norwegian: 'Norwegian',
  Lang.Nyanja: 'Nyanja',
  Lang.Oriya: 'Oriya',
  Lang.Oromo: 'Oromo',
  Lang.Pashto: 'Pashto',
  Lang.Persian: 'Persian',
  Lang.Polish: 'Polish',
  Lang.Portuguese: 'Portuguese',
  Lang.Punjabi: 'Punjabi',
  Lang.Quechua: 'Quechua',
  Lang.Romanian: 'Romanian',
  Lang.Russian: 'Russian',
  Lang.Samoan: 'Samoan',
  Lang.Sanskrit: 'Sanskrit',
  Lang.ScottishGaelic: 'ScottishGaelic',
  Lang.Serbian: 'Serbian',
  Lang.Sesotho: 'Sesotho',
  Lang.Shona: 'Shona',
  Lang.Sindhi: 'Sindhi',
  Lang.Sinhala: 'Sinhala',
  Lang.Slovak: 'Slovak',
  Lang.Slovenian: 'Slovenian',
  Lang.Somali: 'Somali',
  Lang.Spanish: 'Spanish',
  Lang.Sundanese: 'Sundanese',
  Lang.Swahili: 'Swahili',
  Lang.Swedish: 'Swedish',
  Lang.Tajik: 'Tajik',
  Lang.Tamil: 'Tamil',
  Lang.Tatar: 'Tatar',
  Lang.Telugu: 'Telugu',
  Lang.Thai: 'Thai',
  Lang.Tigrinya: 'Tigrinya',
  Lang.Turkish: 'Turkish',
  Lang.Turkmen: 'Turkmen',
  Lang.Twi: 'Twi',
  Lang.Ukrainian: 'Ukrainian',
  Lang.Urdu: 'Urdu',
  Lang.Uyghur: 'Uyghur',
  Lang.Uzbek: 'Uzbek',
  Lang.Vietnamese: 'Vietnamese',
  Lang.Welsh: 'Welsh',
  Lang.Xhosa: 'Xhosa',
  Lang.Yiddish: 'Yiddish',
  Lang.Yoruba: 'Yoruba',
  Lang.Zulu: 'Zulu',
  Lang.Unknown: 'Unknown',
};

LangStorageModel _$LangStorageModelFromJson(Map<String, dynamic> json) =>
    LangStorageModel(
      language: $enumDecode(_$LangEnumMap, json['language']),
      transString: json['transString'] as String,
    )..detailCards = (json['detailCards'] as List<dynamic>)
        .map((e) => CardDetailModel.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$LangStorageModelToJson(LangStorageModel instance) =>
    <String, dynamic>{
      'language': _$LangEnumMap[instance.language]!,
      'transString': instance.transString,
      'detailCards': instance.detailCards.map((e) => e.toJson()).toList(),
    };

CardDetailModel _$CardDetailModelFromJson(Map<String, dynamic> json) =>
    CardDetailModel(
      unit: json['unit'] as String,
      explain: json['explain'] as String,
    );

Map<String, dynamic> _$CardDetailModelToJson(CardDetailModel instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'explain': instance.explain,
    };
