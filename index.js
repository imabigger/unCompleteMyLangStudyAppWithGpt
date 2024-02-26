// npx eslint --fix index.js 사용


// const functions = require("firebase-functions");
const {HttpsError} = require("firebase-functions").https;
// const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const fetch = require("node-fetch");
const {onCall} = require("firebase-functions/v2/https");
const {TextToSpeechClient} = require("@google-cloud/text-to-speech");
const client = new TextToSpeechClient();


exports.gptCallWithUrlAndBody = onCall(async (request) => {
  const apiKey = process.env.OPENAIAPI_KEY;
  const apiUrl = "https://api.openai.com/v1/" + request.data.url;

  logger.info(`Gpt ${request.data.url} called, called by ${request.auth.uid}`,
      {structuredData: true});

  const headers = {
    "Authorization": `Bearer ${apiKey}`,
    "Content-Type": "application/json",
  };

  const body = JSON.stringify(request.data.body);

  try {
    if (!request.auth) {
      throw new HttpsError("UNAUTHENTICATED", "The function must be " +
                  "called while authenticated.");
    }

    const apiResponse = await fetch(apiUrl, {
      method: "POST",
      headers: headers,
      body: body,
    });

    if (!apiResponse.ok) {
      const errorDetail = await apiResponse.text();
      logger.error(`OpenAI API error detail: ${errorDetail}`);
      throw new HttpsError("FAILED_PRECONDITION",
          `OpenAI API responded with ${apiResponse.statusText}`);
    }

    const data = await apiResponse.json();
    return data;
  } catch (error) {
    logger.error(`Error occurred: ${error.message}`);
    throw new HttpsError("internal", error.message);
  }
});


exports.textToSpeech = onCall(async (request) => {
  const req = {
    input: {text: request.data.text},
    voice: {languageCode: request.data.languageCode,
      name: request.data.name,
    },
    audioConfig: {audioEncoding: "MP3"},
  };

  const [response] = await client.synthesizeSpeech(req);
  const encodedAudioContent =
  Buffer.from(response.audioContent).toString("base64");
  return {audioContent: encodedAudioContent};
});
