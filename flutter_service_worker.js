'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "e4c874214332925e323ab811ae018fe8",
"/": "e4c874214332925e323ab811ae018fe8",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"privacy.html": "c3fb32b427f0ec50ae1929578ee8c78c",
"favicon.png": "6a96be389847b5cd465c1a9e3a8a6903",
"main.dart.js": "8006589f145fb0cc87acaf798e1c8f0d",
"version.json": "f49823b94b02d46d9b0a059aad25fcf1",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"manifest.json": "3c47eee05d8d86a8af517e2a4ab17b68",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/fonts/MaterialIcons-Regular.otf": "4a61a7253c4ead034bfd4c76fa7e3e91",
"assets/AssetManifest.bin": "4a6ab77396afe94acabdc1a2c5f583a8",
"assets/AssetManifest.json": "ad377ad856b24364ac903d57023aa6f7",
"assets/NOTICES": "8d57663e10ec37da23c808a8cf53ddf4",
"assets/FontManifest.json": "9d3694b6aa5d83b9d872004a25e3be30",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "bcaf3ba974cf7900b3c158ca593f4971",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/assets/animations/animation_review.lottie": "d2b417f9cd1ad836d1af41f106ea38a4",
"assets/assets/animations/135507-exam-prep-topics.json": "3d8f891ea3d14c457be516ffb48078d5",
"assets/assets/audios/exam/111_listening_19.mp3": "63e3053bdfddeaf032d9ad0133d1e9e9",
"assets/assets/audios/exam/111_listening_21.mp3": "6253b9d06a9cb8e60b9ca65db05cbc10",
"assets/assets/audios/exam/112_listening_18.mp3": "c3d1004da1d2f828c9b86a20bcda990a",
"assets/assets/audios/exam/111_listening_5.mp3": "1939a5f537ec5c6c2eea39bb4f87db01",
"assets/assets/audios/exam/112_listening_9.mp3": "d6519cb07d62a20757c6fa28c7387d90",
"assets/assets/audios/exam/111_listening_10.mp3": "45cc09016ffaff915bbf81ff40f88bbe",
"assets/assets/audios/exam/111_listening_6.mp3": "0c12204b13c5cd6a10129e6835a7218d",
"assets/assets/audios/exam/111_listening_11.mp3": "4bb9dfdb68a8692428aaf6da0045d3c3",
"assets/assets/audios/exam/111_listening_18.mp3": "5a661b75d5cb0b4046f35649748b2584",
"assets/assets/audios/exam/111_listening_1.mp3": "c140ae24e44febfad6b7ca5c9ac912c6",
"assets/assets/audios/exam/112_listening_1.mp3": "def0fc158a0770204b25885a800d304f",
"assets/assets/audios/exam/111_listening_2.mp3": "35cddcccf2111a762835c516dcee0977",
"assets/assets/audios/exam/112_listening_8.mp3": "30915ee994e0aff62511466a527b5fca",
"assets/assets/audios/exam/112_listening_4.mp3": "d0acdcd4c630fb3cbd7a1b8edf3f6d8c",
"assets/assets/audios/exam/111_listening_15.mp3": "6965c5ac558f875c23cb6d78a1a0c70a",
"assets/assets/audios/exam/111_listening_9.mp3": "34dbe8a5c9d128da27befba48694a996",
"assets/assets/audios/exam/111_listening_20.mp3": "327e2ac5c04c8bc672253abd518807b6",
"assets/assets/audios/exam/111_listening_14.mp3": "295da6fc2a397d069c7576c91599de44",
"assets/assets/audios/exam/111_listening_3.mp3": "3f16f00b3206e178ce8e538750f7ad37",
"assets/assets/audios/exam/111_listening_17.mp3": "c63f1fbf7499c2e21bc57af86c004443",
"assets/assets/audios/exam/112_listening_12.mp3": "6be781af7906cdd75ee7a5cae8d271fc",
"assets/assets/audios/exam/111_listening_7.mp3": "2b588eb4b7c76c239596670049bd32fc",
"assets/assets/audios/exam/112_listening_3.mp3": "cf5b4cd2ad6364e17ba58337b4b1a023",
"assets/assets/audios/exam/112_listening_17.mp3": "cb9d8dffe98e0edf14e825cfe7b0e2b6",
"assets/assets/audios/exam/112_listening_21.mp3": "5b25eb09c382d4db71e5d683abcb0eec",
"assets/assets/audios/exam/112_listening_19.mp3": "45d438ef351f24afa81e8cb420454548",
"assets/assets/audios/exam/112_listening_2.mp3": "0baba8a8cc56c713d79f45dbae2c4f64",
"assets/assets/audios/exam/112_listening_7.mp3": "691d517ad8f03da11593951df9aefc38",
"assets/assets/audios/exam/111_listening_4.mp3": "85ed030e7670babd5f0acb06321659c8",
"assets/assets/audios/exam/111_listening_example_2.mp3": "be59956f1b0b8306a2bc4a53ef326c0b",
"assets/assets/audios/exam/112_listening_5.mp3": "297abd81410d2e6203aa93599ea5af0f",
"assets/assets/audios/exam/112_listening_11.mp3": "de7c51851772bc96dc44d2b392d635cf",
"assets/assets/audios/exam/111_listening_example_3.mp3": "53cbdf6a3d165c8d8ce1338cb777d553",
"assets/assets/audios/exam/112_listening_16.mp3": "a24b9de27366ba74a2d37afc69b3bf22",
"assets/assets/audios/exam/112_listening_20.mp3": "0d9bf7e3de990e2eaa60c76e6f187626",
"assets/assets/audios/exam/111_listening_example_1.mp3": "9dbb449f651e99c76da40476a02b9e3d",
"assets/assets/audios/exam/112_listening_6.mp3": "adb1932a532b01b1f68bc63e56386524",
"assets/assets/audios/exam/111_listening_13.mp3": "f34bf53207dddbd4b00b676d5974c671",
"assets/assets/audios/exam/112_listening_14.mp3": "442e4ac96e7e85ebdfc818a954e136b7",
"assets/assets/audios/exam/112_listening_13.mp3": "6bc0a3b56f79b9fe3c889eb484636c45",
"assets/assets/audios/exam/112_listening_15.mp3": "41d660018aa408d372631273a7676c07",
"assets/assets/audios/exam/112_listening_10.mp3": "9bd542e1ed0ecaf0a6a55951832408d9",
"assets/assets/audios/exam/111_listening_16.mp3": "206bbacf5a1a6dc183c53b36e593381b",
"assets/assets/audios/exam/111_listening_12.mp3": "cf85010c8a1ed686101f189a2b02dba2",
"assets/assets/audios/exam/111_listening_8.mp3": "d95473c6871d95b0f0ed8b7fe40e0857",
"assets/assets/config.json": "ac131a2d11cd992448e98a2272b5ceab",
"assets/assets/cap_exams.json": "595dc3571c24dff7e6a086e65e0d89ca",
"assets/assets/images/logo.png": "6a96be389847b5cd465c1a9e3a8a6903",
"assets/assets/images/materials/homework.png": "f6c8cdcf894555889bef4c81a94a386a",
"assets/assets/images/materials/dice.png": "5c13d9e55588305c1905c2dd472ae73f",
"assets/assets/images/materials/awards.png": "fa0ab26c80860e0239b4def09ae25677",
"assets/assets/images/exam/111_society_52-54.png": "c1eb68b21278ded841a526c5097d8bba",
"assets/assets/images/exam/111_math_24-25.png": "adff299cbb6bde78bb7ac68fb291ca8e",
"assets/assets/images/exam/112_nature_31.png": "91e7ae47184724281ddf613b317f8683",
"assets/assets/images/exam/112_society_23.png": "156c62fd2e90ab113a3d1a435b237b66",
"assets/assets/images/exam/111_nature_8.png": "b5fde9b3e90953278d9e1cce06705cc7",
"assets/assets/images/exam/110_nature_32.png": "a07b9795c2216bfeb7fb41ea62fa3bda",
"assets/assets/images/exam/112_nature_18.png": "a0dc6b670447af2f97f54e699a635758",
"assets/assets/images/exam/111_society_43.png": "753559bfc5f53b1387522d185fbb843d",
"assets/assets/images/exam/112_listening_2.png": "6c33232656ff8929f18eec0d71cc0a4c",
"assets/assets/images/exam/112_math_7.png": "469c5d8395929393cf1b6b25a31d3355",
"assets/assets/images/exam/110_nature_38.png": "3066d646aab9cf47e9ef3bbfcf03c87b",
"assets/assets/images/exam/111_nature_39.png": "ab1a1f3b4ab9babf1a83b3c675e9022a",
"assets/assets/images/exam/112_nature_34.png": "f1f7ed9f20c40a48206b2385435ad1b7",
"assets/assets/images/exam/110_nature_1.png": "623cec12449a14e74a7db031b9276e88",
"assets/assets/images/exam/111_chinese_28-29.png": "f05537c96694ce4a6994b600c0fcfc92",
"assets/assets/images/exam/111_math_9_explanation.png": "7db097e3fb06a9ae2c535475c8118a5a",
"assets/assets/images/exam/111_listening_example_1.png": "9a33ec00580e0c79bdc6460f8cfd1e80",
"assets/assets/images/exam/112_nature_32-1.png": "3f50ceffe2505347392d6422999e83ec",
"assets/assets/images/exam/111_society_13.png": "345784dfadb50246a1917496b3ce9d4d",
"assets/assets/images/exam/110_nature_50-51.png": "6fef4d7e0794b2b3107e91ba71a5d759",
"assets/assets/images/exam/112_nature_32-2.png": "7e49b3b49881070855f2654ba92780ec",
"assets/assets/images/exam/111_society_27.png": "5ded10d42077fb77241ea8c1cd1883f7",
"assets/assets/images/exam/110_nature_28.png": "5b38daf2d95bb569f5118097732f4a8b",
"assets/assets/images/exam/111_nature_23.png": "8ff991ef2c3e08e5a1da169863da32fc",
"assets/assets/images/exam/112_society_27.png": "2c81459f8763b393879dc800b31b8dd2",
"assets/assets/images/exam/112_nature_28.png": "f0a27ace53a2160ee2d8be85aa8d6796",
"assets/assets/images/exam/111_english_21-22.png": "8dc852049ddad6c420d6d5ed15d5e9a2",
"assets/assets/images/exam/111_nature_20.png": "9e967f370c30813b2c99d92ef0968ff3",
"assets/assets/images/exam/111_chinese_25.png": "6b33e4c5038f87cfeb06b2f0438ecbd8",
"assets/assets/images/exam/112_society_2.png": "7647327d4df83b3889b3d13e6f80f03b",
"assets/assets/images/exam/111_chinese_21.png": "f5cb65e5d166bd5a3662ee3ac7891301",
"assets/assets/images/exam/112_chinese_8.png": "0e1b8cb8a2c90f25a2c63b429a1391e9",
"assets/assets/images/exam/111_nature_47-48.png": "2b0060f513271bfbfcb0397514ae0cb0",
"assets/assets/images/exam/111_society_20.png": "082366272343a60454d1ff0233d65255",
"assets/assets/images/exam/111_english_37-39.png": "72d80d1289aa68c8813ce57de04773a7",
"assets/assets/images/exam/112_society_47.png": "45bbd5ef4712b745f1f23df51fcf83bb",
"assets/assets/images/exam/112_society_7.png": "81705568e22135478043bf8c4ab601b0",
"assets/assets/images/exam/112_nature_30.png": "2898aea0fbc078fa8cf8bc90bc4f5336",
"assets/assets/images/exam/111_nature_16.png": "15b869c56fc85c56f162d0da515d7a35",
"assets/assets/images/exam/112_society_19.png": "5bc3c477194ebaa9d871dee9c88cead7",
"assets/assets/images/exam/111_society_24.png": "4cce1582411680be2c09f4383fe9b6ce",
"assets/assets/images/exam/112_nature_13.png": "547be3ceb2c4712e194955dc9d5d2a7c",
"assets/assets/images/exam/111_nature_7.png": "153a36f90be8426ffa60d0fae6b323ab",
"assets/assets/images/exam/112_math_8.png": "7795688142b34e8248fe45dd3e5c24f2",
"assets/assets/images/exam/112_nature_29-2.png": "d5c19f5143b29c648aeadd905a8611e4",
"assets/assets/images/exam/112_math_19.png": "ed545eb05da62053dfbcca5f9e9e11e8",
"assets/assets/images/exam/111_society_40.png": "037d5d8600b6ed30d33ad3ad07c55922",
"assets/assets/images/exam/112_chinese_21.png": "4271e58aad1fed0626d31de26a017753",
"assets/assets/images/exam/110_nature_42.png": "b80a5c1bb7049d176bae9656e7912649",
"assets/assets/images/exam/110_nature_18.png": "5b908d48ea3834128d5f91debce6c9cf",
"assets/assets/images/exam/110_nature_52-54.png": "4e05636b5fe87bf4251471611c4b8422",
"assets/assets/images/exam/111_nature_49-50.png": "e6ba26468d2d9fd2a3860a849f374573",
"assets/assets/images/exam/111_math_1.png": "381a3113d0dda05430c4df5306102e83",
"assets/assets/images/exam/111_nature_41.png": "153ab2b30271c6a38f653c949d340562",
"assets/assets/images/exam/112_nature_47-48.png": "83f7182249f31d4be3bd0aa60637515e",
"assets/assets/images/exam/112_nature_29-1.png": "d2eca9f309031336655bf93b516d826d",
"assets/assets/images/exam/110_nature_43.png": "c542fb4a4f2fcf0c7a2b1c6add9be998",
"assets/assets/images/exam/110_nature_48-49.png": "64e0cf1e29af053098665e3316820ded",
"assets/assets/images/exam/112_society_4.png": "4b3dd8124b20777eae06415795b2fe07",
"assets/assets/images/exam/111_math_11.png": "4b58af70112c77c6c48670ff8797d6f3",
"assets/assets/images/exam/112_english_1.png": "ab7fd6792264671f7014ee5fe32be2b4",
"assets/assets/images/exam/111_society_16.png": "63bf02a6c01d628a4641772515a881e2",
"assets/assets/images/exam/111_listening_3.png": "5f2866d7f21cbae939ac78311aebf767",
"assets/assets/images/exam/112_society_15.png": "ebc49e7ac54b3eea8150912c94600b14",
"assets/assets/images/exam/110_nature_35.png": "ffe889276ccd83c686e13d6a85e0cb7d",
"assets/assets/images/exam/111_math_20_explanation.png": "b0e0ce9e78cd5efb5352125f2b9f5caf",
"assets/assets/images/exam/111_nature_35.png": "827c08840855a3d048ae860e016814c4",
"assets/assets/images/exam/112_nature_33.png": "7f714dfb86874359e8d086b77d43e9bb",
"assets/assets/images/exam/110_nature_12.png": "79ea2883d8c675a6e7654fb7f765b9e6",
"assets/assets/images/exam/111_society_41.png": "23b5a019789d6b7ed6551d764e6b692b",
"assets/assets/images/exam/112_english_42-43.png": "3e6d6e4f6a69a248bebfb70fee952043",
"assets/assets/images/exam/110_nature_31.png": "301069bad346026fb7ac421df268a4be",
"assets/assets/images/exam/112_listening_3.png": "1713b96fe9170364b63432b005654d70",
"assets/assets/images/exam/112_society_31.png": "eeefdf731995df0d93efa98184c425a6",
"assets/assets/images/exam/111_nature_48.png": "b1479be3f6fa021510866f209d6c1107",
"assets/assets/images/exam/112_society_52-54.png": "3cd8db5768e872820ef224914547bede",
"assets/assets/images/exam/112_math_18.png": "9783527c8ee194e4f645acb22cb16bee",
"assets/assets/images/exam/112_nature_43-44.png": "873f2b7321e632b160d6778d241f8610",
"assets/assets/images/exam/112_society_38.png": "e3d2590d9cd1577f585c5e69ff6a07ae",
"assets/assets/images/exam/112_chinese_29.png": "a53ef9c517fd49652e6f97b4ab50cf49",
"assets/assets/images/exam/110_nature_24.png": "ef285058864e67ecc5334ea7ed41331f",
"assets/assets/images/exam/110_nature_45.png": "fa4a6c8e701a654b40f5c7f56090cf7d",
"assets/assets/images/exam/110_nature_22.png": "088a3621ed86a7832bac694e54cdfa61",
"assets/assets/images/exam/111_nature_40.png": "8e0264f178ba8d4b7d991353293e0494",
"assets/assets/images/exam/111_society_2.png": "712fa2ac3cc4e5902eda88e2972b6590",
"assets/assets/images/exam/111_chinese_11.png": "c5b0db5e969ca456f859b1829f3fc9cd",
"assets/assets/images/exam/112_nature_14.png": "162720ed8dbffc2fe33ef2b4a5fe55fd",
"assets/assets/images/exam/110_nature_29.png": "dd6925419db25bb03883a6a89653582d",
"assets/assets/images/exam/112_nature_39.png": "23326a62a73c8d431bf5a736dd2d7d1f",
"assets/assets/images/exam/111_chinese_30-31.png": "c4358019a02408e54a3b98a035b672ee",
"assets/assets/images/exam/111_chinese_4.png": "8be5660353c0fc7ed5c07ff48c650415",
"assets/assets/images/exam/112_chinese_27-29.png": "cc1558ea8beb80e64132ed4f4f9ce598",
"assets/assets/images/exam/112_english_26-27.png": "1fccc91785da14158dcf2d314429e924",
"assets/assets/images/exam/111_society_3.png": "a7bcf11732f48908b3c8e85f19467627",
"assets/assets/images/exam/110_nature_44.png": "899e00aa640d6b036310544a2c7f0d26",
"assets/assets/images/exam/111_society_19.png": "29b69169902c3a602fea87773cea5dfb",
"assets/assets/images/exam/111_chinese_36.png": "8a1be52284f6721f653b88a4f029dd72",
"assets/assets/images/exam/110_nature_40.png": "c8027d06a31c9f43a8cbea06ea29bbed",
"assets/assets/images/exam/111_nature_25.png": "b180bfaa2cf341561392b04afa22e68c",
"assets/assets/images/exam/111_nature_26.png": "b820d81645d04a3d3663b2a1d61ae50e",
"assets/assets/images/exam/112_english_30-32.png": "1ab59c0f8bbff1b2c71588c740df3a1a",
"assets/assets/images/exam/111_nature_17.png": "c083c2b4fff82cdeea5a46b746722486",
"assets/assets/images/exam/111_nature_47.png": "a28699df4b7205a8f82a154058a4479b",
"assets/assets/images/exam/111_english_30-32.png": "0ab39b7ccde5d398083f171248aa3c0b",
"assets/assets/images/exam/112_math_13.png": "98f8c3ae6bd15acfcb80d5608582a2bb",
"assets/assets/images/exam/112_nature_23.png": "f3d8fed128f20a99509c89f1be05c7b8",
"assets/assets/images/exam/112_chinese_25-26.png": "cf6d0e2be02071b3e21550341c01868d",
"assets/assets/images/exam/112_listening_1.png": "f4bbe308870116ad2f342542602c7bbe",
"assets/assets/images/exam/111_society_18.png": "8e24dfc2b76c5f3a04681c96dfed61f2",
"assets/assets/images/exam/112_chinese_38.png": "6358a76f97d002f509e56e18bc7405ac",
"assets/assets/images/exam/112_math_17.png": "ba51c3ac59d03e1f76faeed95928f855",
"assets/assets/images/exam/112_nature_15.png": "7cf5960ccace4a885ac855060a220f70",
"assets/assets/images/exam/112_english_33-35.png": "8b460b264c303928eedb1c9a6a592a2c",
"assets/assets/images/exam/111_society_28.png": "5a610ff725f2ddc6a0b0aac2911cb2f3",
"assets/assets/images/exam/111_society_8.png": "692d28d6a97f382e53a40c671726939f",
"assets/assets/images/exam/110_nature_16.png": "7130ea75635d1747ce96d3732428cbaf",
"assets/assets/images/exam/112_nature_25.png": "d196cb92047b822c38be2e4794c2ce0e",
"assets/assets/images/exam/112_society_49-51.png": "bf4f65ecf4f57d1be0a1a24a8a7c99a8",
"assets/assets/images/exam/111_english_1.png": "59456931cde33626c405962e9d2322ab",
"assets/assets/images/exam/110_nature_7.png": "11734355e5beb4f92a7f12b6783f6822",
"assets/assets/images/exam/110_nature_8.png": "7080342c68fa08db22ba753a0a88f35f",
"assets/assets/images/exam/112_society_10.png": "f2baa4947ed81a9ed12c8a12a7135a86",
"assets/assets/images/exam/112_nature_19.png": "0a8cb0d919189f7eff2f2a307cb494d1",
"assets/assets/images/exam/111_math_19.png": "9cab97038dbc0eae5d7b54a9d93189d9",
"assets/assets/images/exam/112_nature_10.png": "4d9e4f41af5d4a9b426864cb8af23ff1",
"assets/assets/images/exam/111_math_18.png": "2709feb5074ffa6eb6e598e2de2cd3b9",
"assets/assets/images/exam/110_nature_3.png": "20cc97ab7f4382522dbea275fc5542ab",
"assets/assets/images/exam/111_society_36.png": "875b3de9f7ec8ca89bd15c1e6595cbe2",
"assets/assets/images/exam/111_nature_24.png": "283c9314e8899ab34f598382234b77a6",
"assets/assets/images/exam/110_nature_26.png": "d1bfd84f08b70226fa17d6a6538e556a",
"assets/assets/images/exam/110_nature_27.png": "cddea55ddd278c5dc57e6bcb8e8dcb9a",
"assets/assets/images/exam/111_english_27-29.png": "6ffafc12682192839b6c225aa5e45e42",
"assets/assets/images/exam/111_math_21.png": "1e34a6097f67bbac230b9da1847ccb98",
"assets/assets/images/exam/112_society_43.png": "4c7117b2af1f63417f7af9fa4bd020f2",
"assets/assets/images/exam/111_nature_33.png": "f33ea82b3d23b8eff74f3710e442631b",
"assets/assets/images/exam/111_nature_42-44.png": "f41ef0a162056a2779229511c40c50fe",
"assets/assets/images/exam/112_nature_36.png": "37061627f8b54e5e001abe40e9537107",
"assets/assets/images/exam/111_nature_11.png": "bc452a7a36bc6c19ab762820b60106a9",
"assets/assets/images/exam/111_society_15.png": "52c3a7165f46537065ea1ed1dd91747c",
"assets/assets/images/exam/112_english_25.png": "33a7f5628622002402a045acd00e54b2",
"assets/assets/images/exam/110_nature_17.png": "d52b3c07d9c40bd666e490351c5355e1",
"assets/assets/images/exam/112_nature_22.png": "d76089b66be560ebc72a74a072c32d51",
"assets/assets/images/exam/111_nature_34.png": "1685a8f8917ce3c9c36fd07866a3ae02",
"assets/assets/images/exam/111_society_12.png": "540f600f07c0bd9c0558445d681889e1",
"assets/assets/images/exam/111_chinese_34-35.png": "56c013517ad113f09731e6a851189193",
"assets/assets/images/exam/111_society_39.png": "03f35db4936588890a2f000f8c9228c8",
"assets/assets/images/exam/111_society_38.png": "f3e4e7f8acb6f6178e0c975805a0bc39",
"assets/assets/images/exam/111_society_5.png": "8c2ee3d9ffdca30d98459ca6a28ec332",
"assets/assets/images/exam/112_nature_41.png": "35f628433887cc689f460ef813dc3dc2",
"assets/assets/images/exam/111_society_31.png": "6c15df61abace8749ee292e0d2c5a89e",
"assets/assets/images/exam/111_nature_38.png": "3960c7877c1abaa5060806d30263bdce",
"assets/assets/images/exam/112_society_28.png": "4874c634d4dee9c5feb627633f25b66a",
"assets/assets/images/exam/110_nature_11.png": "6d609e5ea16bfc41b562a9cd478d5ab4",
"assets/assets/images/exam/112_nature_7.png": "cfebb8aa2a29829e83a1240963315110",
"assets/assets/images/exam/111_society_1.png": "e9242a3ba98753f6c179cdf848240d58",
"assets/assets/images/exam/112_chinese_17.png": "1cedf25dbc97305cdb705d5b25bab962",
"assets/assets/images/exam/111_math_14.png": "2c8b5bd169274fac8ba528b9d72d6abf",
"assets/assets/images/exam/111_society_53.png": "cc4ef0a141f0d099adcab6eaae07d77f",
"assets/assets/images/exam/112_math_21.png": "266a1c8264a575dbec3f024780eeac09",
"assets/assets/images/exam/111_english_40-43.png": "fe6393e28dc886268ba9047313234716",
"assets/assets/images/exam/112_nature_20.png": "e51b2b3e6be7c3832c5cf53219baab72",
"assets/assets/images/exam/112_nature_37.png": "831f3d9c06f6382917d538d9278c3533",
"assets/assets/images/exam/110_nature_39.png": "d7f611bd192cf2c6f6c070164717a37b",
"assets/assets/images/exam/110_nature_53.png": "963ff6d483f91d3f1cc4819a0a8fcb7c",
"assets/assets/images/exam/112_nature_2.png": "9b0c10e612ef262fd9589ab4de4e1484",
"assets/assets/images/exam/112_society_11.png": "0c2bc48b2633d724faa59757508aedb9",
"assets/assets/images/exam/112_english_36-38.png": "5b058a80b5e0150ab721c6783ad7728c",
"assets/assets/images/exam/111_nature_28.png": "28eb23503e3b289bb6e4cf63b40f13f0",
"assets/assets/images/exam/111_math_15.png": "9fb6ae90ba089a97b6631db2bf57b0af",
"assets/assets/images/exam/112_society_40.png": "00a90113bff4bc69e77fcda7ee7dec0c",
"assets/assets/images/exam/112_math_22.png": "71b88ecfcb09c58068b1c8ddf07f4ab4",
"assets/assets/images/exam/111_nature_30.png": "ce630e9d3652d615a79f98d142dbab0f",
"assets/assets/images/exam/112_society_14.png": "da9f5bb1029487d39a567989504cb846",
"assets/assets/images/exam/112_society_39.png": "728370cfe772e7e206835844bb99cee7",
"assets/assets/images/exam/111_society_6.png": "b04c1b0ce5856f61b515a2d551ddf412",
"assets/assets/images/exam/111_english_33-36.png": "77a7a0fbc535879c0b193a384c850e87",
"assets/assets/images/exam/110_nature_19.png": "0d9adce3a0d83774f93a3077b376ce84",
"assets/assets/images/exam/112_nature_17.png": "e5407faaf0e9af6d9a3a560df445637a",
"assets/assets/images/exam/112_english_24-25.png": "85db4b29c64350c6b3ddb244a0ef2c43",
"assets/assets/images/exam/111_nature_43.png": "f7f8430095c3858e8787c3e46c1f1dd2",
"assets/assets/images/exam/112_chinese_9.png": "867355b151c58ce830966b103a87ec1f",
"assets/assets/images/exam/112_nature_45-46.png": "2ef49ac90675c5cedb8a2f3191297d61",
"assets/assets/images/exam/110_nature_20.png": "a6176fc66404a39f39609df096d396f9",
"assets/assets/images/exam/110_nature_37.png": "e98e2ee04c30fd1b48ec08aa547be0e3",
"assets/assets/images/exam/111_listening_1.png": "ebe395988ec66e373701061fa6a6ca47",
"assets/assets/images/exam/112_society_25.png": "e72d919eaa3e60b3785befd0d9a8cf84",
"assets/assets/images/exam/111_math_23.png": "bd8c029657a0fda5db49423bd8154843",
"assets/assets/images/exam/112_math_3.png": "d197ae022c330e765ccdb16341c1ff12",
"assets/assets/images/exam/110_nature_36.png": "514bdc5d39ae1c90fa5656ca8ff274a3",
"assets/assets/images/exam/112_nature_21.png": "d64d226aa839a1444d6403ab388328f0",
"assets/assets/images/exam/111_math_25.png": "1430fadc68b42abf1e86c9692c8769f0",
"assets/assets/images/exam/111_math_13_explanation.png": "252af88d11aa6d17aada09a922d8f22a",
"assets/assets/images/exam/112_math_11.png": "c8244c6122431a11d88f8515ecf6b6e5",
"assets/assets/images/exam/112_english_28-29.png": "0d67d16901614e3308d748f2392ce263",
"assets/assets/images/exam/112_society_26.png": "29f6759166bbfa7e8cb0b1f01cea4082",
"assets/assets/images/exam/111_chinese_1.png": "e85784e9174f0af8220b3a5309434740",
"assets/assets/images/exam/111_math_21_explanation.png": "6ca30d5aee4bb9d523df0fdbeba6ab31",
"assets/assets/images/exam/112_nature_5.png": "32f110083bfa42127adeb3b38274a4e0",
"assets/assets/images/exam/112_math_12.png": "1b66b8cca35420f6a867e04db0bf8bfc",
"assets/assets/images/exam/111_math_19_explanation.png": "e3a70776af06271e2752bfec8a87ae00",
"assets/assets/images/exam/111_nature_15.png": "390c8446dc8893e9477a39e4cc806bfe",
"assets/assets/images/exam/112_listening_18.png": "e82f77b0a8f553535ee843ec2919be8f",
"assets/assets/images/exam/111_english_33.png": "5de587692977a00b14db91d4ed4ea24a",
"assets/assets/images/exam/111_math_4.png": "49f23030f05368ae154b8375cfa9ffbc",
"assets/assets/images/exam/112_math_23.png": "33290c52dd4a5b08443b3c2a7bc6c5fc",
"assets/assets/images/exam/111_society_23.png": "761ba8f0b01bc2b4b92883c600a9206b",
"assets/assets/images/exam/111_nature_21.png": "d13cdb4955aca3ebf1898c10a1e80c1a",
"assets/assets/images/exam/111_nature_45-46.png": "e5195c5ac5907f41523b7390d1bed711",
"assets/assets/images/exam/111_society_33.png": "3400eb8f81f15c8709786daaabdb601c",
"assets/assets/images/exam/112_nature_42.png": "f4177a07a5d6ac60909438f3130214e6",
"assets/assets/images/exam/112_math_24.png": "9292b7b53613c10bd570db75aca6b3d5",
"assets/assets/images/exam/111_math_17.png": "9cbeb8860df1933d84fb835f78a55066",
"assets/assets/images/exam/111_nature_12.png": "1ae35a924b64441d5e18c4434888128e",
"assets/assets/images/exam/112_society_41.png": "46929731a0e5cd7c4168dd95f1a40901",
"assets/assets/images/exam/112_nature_3.png": "bbfea7c01a360c33cd2942192c71e9ae",
"assets/assets/images/exam/112_nature_24.png": "d82256293b82f56488062c954b4b0275",
"assets/assets/images/exam/110_nature_33.png": "0cd059b8172f888d8065a9741b769b40",
"assets/assets/images/exam/111_society_11.png": "6a2eb58eb02a5ca0c243e5f67a82d798",
"assets/assets/images/exam/111_listening_2.png": "f26d4600e148a1a2a70c268e9836f02f",
"assets/assets/images/exam/111_society_26.png": "c765584cf2600007b3e7aa1a7f15fe48",
"assets/assets/images/exam/111_society_46-48.png": "949b673f9f59cfc33d599d273a4ff1e2",
"assets/assets/images/exam/112_society_6.png": "f63a76c36eb2365727f016454142fb76",
"assets/assets/images/exam/111_math_4_explanation.png": "6d4fba02557ba64b9097edb8ffd2d2d8",
"assets/assets/images/exam/112_chinese_6.png": "1b15b91d6d4f3a185bdb25540c80ade0",
"assets/assets/images/exam/111_math_17_explanation.png": "124396c29f74930e9bb445d72d097790",
"assets/assets/images/exam/111_chinese_26-27.png": "3659415037ad255338d2f97f9a284ef5",
"assets/assets/images/exam/111_society_42.png": "ced92aa1cd9c3a3c3f43e06c2f26c9c4",
"assets/assets/images/exam/111_nature_42.png": "c835699f35ea271112d36789ff3472cc",
"assets/assets/images/exam/111_english_22.png": "d1a84a0d608bb03fa7b666126e0f030c",
"assets/assets/images/exam/111_society_29.png": "28cbe9b9eaa319561dd6de65a901729d",
"assets/assets/images/exam/111_nature_27.png": "d7a44fdf5dec7206a9c5c8e7b671e57a",
"assets/assets/images/exam/111_math_13.png": "19b02085b20660e17c382e768564f6c7",
"assets/assets/images/exam/111_english_23-24.png": "60a60bc3e20bba0ae8817f1d5c892e28",
"assets/assets/images/exam/111_math_20.png": "29b7d6fb2e32f28ab423ceee7115d275",
"assets/assets/images/exam/112_math_14.png": "aa3f28dcc2880458718c6960c69998cc",
"assets/assets/images/exam/111_math_16.png": "82b0631b187245a8e2b31622ba5457eb",
"assets/assets/images/exam/112_math_20.png": "2249f8989c0b9eb23184eb621084c5c5",
"assets/assets/images/exam/112_nature_49-50.png": "e02cd621a2186b202023ffc2307a2c4a",
"assets/assets/images/exam/112_nature_35.png": "a8d5dec81c4df6de8a6676ce4a585cf3",
"assets/assets/images/exam/112_nature_11.png": "2365397f360ee3a0c6fd288643b2de5a",
"assets/assets/images/exam/112_society_46-48.png": "6c0e87e06540eabefae50a539cf60366",
"assets/assets/images/exam/112_society_34.png": "37b307a87014b667228aed53ed613dc5",
"assets/assets/images/exam/112_nature_6.png": "20aebc76ced90dca0ea7a9bf0596f3e6",
"icons/Icon-maskable-192.png": "6a96be389847b5cd465c1a9e3a8a6903",
"icons/Icon-192.png": "6a96be389847b5cd465c1a9e3a8a6903",
"icons/Icon-512.png": "6a96be389847b5cd465c1a9e3a8a6903",
"icons/Icon-maskable-512.png": "6a96be389847b5cd465c1a9e3a8a6903"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
