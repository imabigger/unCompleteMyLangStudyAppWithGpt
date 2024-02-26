# unCompleteMyLangStudyAppWithGpt
완성하지 못했지만, 내가 2023 여름방학동안 참 열심히 만들었던 프로젝트이다.

페이지 네이션, Api 콜링, gpt api 연계 등등.. 만드느라고 참 애썻었던 기억이 난다.

미완으로 끝낸 이유는, 만들다 보니, 이걸 누가 쓸까... 라는 생각이 들어서 그냥 접었다.

firebase와의 연계도 끊을 것 같다.

2024-2-26 다운 그레이드를 완료했다. 이제 이 앱에서 gpt calling 등 function은 사용되지 않는다.

js등의 파일은 firebase function 에 관한 설정을 하느라 넣어 논것이다. 이제 쓸모 없지만.

밑에는 이 앱의 사진들을 추가하겟다.
![스크린샷 2024-02-26 173723](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/709552c8-4813-418c-8ee4-e4a69975aea7)
![스크린샷 2024-02-26 172845](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/429adb39-22bd-473a-8716-dbd9749c3f12)
![스크린샷 2024-02-26 172825](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/5c607172-27f3-4a84-95b0-b7c8419efc1d)
![스크린샷 2024-02-26 172755](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/9c02f4ef-17dc-422e-9c0a-7905cb65ea73)
![스크린샷 2024-02-26 172734](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/a8f72145-8d1f-4738-9fb2-3a1ee1a1b2a5)
![스크린샷 2024-02-26 172711](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/ec01b36f-eefc-4480-9d4b-d8a02c16043e)
![스크린샷 2024-02-26 172657](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/cde2ae33-6b09-4397-a819-b3893aa794e7)
![스크린샷 2024-02-26 172644](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/580a00fe-3643-4021-9d37-21c6eb69a019)
![스크린샷 2024-02-26 172607](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/28781aae-38d8-4599-8a40-c3acf3c82440)
![image](https://github.com/imabigger/unCompleteMyLangStudyAppWithGpt/assets/122725714/d8e4e7a7-76f5-4c71-aa3d-ee7349394390)
마지막 사진을 보면, 내가 하고싶었던걸 설명할 수 있을 것 같다.
카드 하나하나가 클릭하면, 사용자 지정 언어로 번역이 나온다.
조그마한 틈을 클릭하면, 밑에 삭제, 정보추가, 오디오 추가 가 나오는데
1. 삭제 : 카드를 삭제한다.
2. 정보추가 : 카드 문장을 gpt가 분석해서 단어마다 나누어 준다. 또한 사용자 언어로 해설을 gpt가 보내준다.
3. 오디오 추가: 해당 언어로 구글 클라우드 TTS 서비스를 이용해서 문장을 읽어주는 오디오를 추가한다. 한번 추가하면 앱에 기록되어 다시 요청을 보낼 필요가 없다. tts 보이스 선택은 info 탭에서 선택할 수 있다.

핵심은 2번이었다.
문장을 gpt가 단어마다 분석해주고 해설을 해준다면, 언어 공부가 쉽지 않을까? 라는 생각이었다.
이 부분에 꽤나 열을 들었던 거 같다.
지금은 gpt api key도 비활성화 하고, firebase도 비활성화, google cloude도 비활성화 했기 때문에 작동하지 않는다.
