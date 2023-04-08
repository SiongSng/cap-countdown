'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "3dbd05be6db4a4154ce733ff194dcae7",
"canvaskit/chromium/canvaskit.js": "c5ff0f8767a7ea0962b15d1f1832002d",
"canvaskit/chromium/canvaskit.wasm": "c6b1144d5baffbdd9482ee820dbd7dc9",
"canvaskit/canvaskit.js": "3e7c7e90ff8e206f4023c12e31b0d058",
"canvaskit/skwasm.wasm": "f767200511478d7f7052f2b536d82875",
"canvaskit/skwasm.worker.js": "23be0fdafa5ddef67734292a576f8fe3",
"canvaskit/canvaskit.wasm": "296ba26fdb37b50c239d4ead66144d01",
"index.html": "bf9cf71dd7c5181977bc3d280ff7aea9",
"/": "bf9cf71dd7c5181977bc3d280ff7aea9",
"main.dart.js": "88eb03c051eacbd874543d507885929c",
"icons/Icon-maskable-192.png": "ff3de03be0b72d00ed03476236e9ef4e",
"icons/Icon-512.png": "ff3de03be0b72d00ed03476236e9ef4e",
"icons/Icon-maskable-512.png": "ff3de03be0b72d00ed03476236e9ef4e",
"icons/Icon-192.png": "ff3de03be0b72d00ed03476236e9ef4e",
"manifest.json": "3c47eee05d8d86a8af517e2a4ab17b68",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "ff3de03be0b72d00ed03476236e9ef4e",
"version.json": "0d0137b7514f3e3021aad9e027b8bace",
"assets/shaders/ink_sparkle.frag": "57f2f020e63be0dd85efafc7b7b25d80",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "39be7f280b24d4a295190a3a2bd60f03",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/fonts/MaterialIcons-Regular.otf": "cbce03d45da397009ab972c46c25a413",
"assets/FontManifest.json": "9d3694b6aa5d83b9d872004a25e3be30",
"assets/NOTICES": "a712a9e4db763f097d5f49aa43d04883",
"assets/AssetManifest.json": "c984e6df749cc178274a60cb64a742ac",
"assets/assets/cap_exams.json": "13bc2293cac7b3e4ffaf26dd4ffd4377",
"assets/assets/animations/135507-exam-prep-topics.json": "3d8f891ea3d14c457be516ffb48078d5",
"assets/assets/animations/animation_review.lottie": "d2b417f9cd1ad836d1af41f106ea38a4",
"assets/assets/images/materials/homework.png": "f6c8cdcf894555889bef4c81a94a386a",
"assets/assets/images/materials/awards.png": "72f6e01813c3c4937bbb249961f463c4",
"assets/assets/images/materials/dice.png": "da4f2f5638d9e5bf4d7d7e349512be39",
"assets/assets/images/exam/111_society_39.png": "0b7be06721ac57ebf0b086a3039607f1",
"assets/assets/images/exam/111_society_53.png": "50cecff54834e647d6d002a8a524b816",
"assets/assets/images/exam/111_society_46-48.png": "5f50c8f0add1b9892d84fbdce6f6e562",
"assets/assets/images/exam/111_society_19.png": "f27d1a6f0a8501eba9cf8c2c8a64ad62",
"assets/assets/images/exam/111_society_29.png": "dba217affe6cf1cc4d3ac2d9f3b981a2",
"assets/assets/images/exam/111_english_23-24.png": "1a32ed6cf7d89b80fa71cd422836f537",
"assets/assets/images/exam/111_society_12.png": "8bb94d6019fc5ad920ca5b08aff66c04",
"assets/assets/images/exam/111_society_40.png": "9905e9de5ba8f2dcb0399a40567120fa",
"assets/assets/images/exam/111_society_33.png": "3987e4d5a8cafe63d38ec6f4c43bd159",
"assets/assets/images/exam/111_society_28.png": "dbb5be3de5f4f7e3eb8a16d0b91047b0",
"assets/assets/images/exam/111_society_24.png": "0313d4d37c3b37cc842d95753d24dd23",
"assets/assets/images/exam/111_chinese_4.png": "cafb54eb6731a883094482a694fc9d4f",
"assets/assets/images/exam/111_society_38.png": "4f95af29430d2083d028382eef65a263",
"assets/assets/images/exam/111_chinese_25.png": "edda0e53edf2d36b8df49aa2f3c8fc8b",
"assets/assets/images/exam/111_society_16.png": "a2e32ad090cd2d99045d77028f67f267",
"assets/assets/images/exam/111_society_41.png": "9ee2f0c40a17f79fe7a41a50595650e6",
"assets/assets/images/exam/111_society_2.png": "02d3c12b811880e711d514b8040d3654",
"assets/assets/images/exam/111_society_5.png": "fa0b728cf3e00c87a57fae4e14cf9cd5",
"assets/assets/images/exam/111_math_1.png": "b87d12132285e18a7a5724d624b8b01b",
"assets/assets/images/exam/111_chinese_26-27.png": "33a1ca935c9548103b1f3a152c13803e",
"assets/assets/images/exam/111_society_1.png": "ea85e7d3fd111ff2e2eec14265b00fd4",
"assets/assets/images/exam/111_english_33-36.png": "fde9f2695f2f87b28c1489ffa7625d11",
"assets/assets/images/exam/111_society_31.png": "2d6e4a2b6358100cac8a0542ac562f56",
"assets/assets/images/exam/111_english_21-22.png": "4cf5299b716a46f142d450dfd47dbc82",
"assets/assets/images/exam/111_chinese_28-29.png": "73acc0602a6496a7af93a4f94f4a695d",
"assets/assets/images/exam/111_society_8.png": "cbd9161f707f740a4ddd768cf36aa9a2",
"assets/assets/images/exam/111_society_20.png": "e9b09723bb43d6c3ee915a1e1988e679",
"assets/assets/images/exam/111_english_37-39.png": "63169af77057e01fcb5ac4506d2846b8",
"assets/assets/images/exam/111_society_6.png": "79011512ac2e419e8b0a3994cadd12cc",
"assets/assets/images/exam/111_english_40-43.png": "00dcb46ceed752e0abe0060eb28a9e68",
"assets/assets/images/exam/111_chinese_30-31.png": "969a822b964224fd030a9179758b89b2",
"assets/assets/images/exam/111_listening_1.png": "9354d0458d63dbfafee37807149a411a",
"assets/assets/images/exam/111_society_42.png": "21d1207187f4da4164bf1ba638bdf1f4",
"assets/assets/images/exam/111_listening_2.png": "90892d7c92f1709781ac11c12b6fc91f",
"assets/assets/images/exam/111_english_33.png": "084a57d73f94df0106ec3a09167b6d0a",
"assets/assets/images/exam/111_chinese_34-35.png": "b3e1b6cd4274f88f3fd2c362090a181a",
"assets/assets/images/exam/111_chinese_21.png": "36d675f4b79d31cd5d93e45c98b272a3",
"assets/assets/images/exam/111_listening_3.png": "ed35cbfbe63056b6222b577db98282af",
"assets/assets/images/exam/111_society_43.png": "81346d2d2cee085ff0da40b4194b9fee",
"assets/assets/images/exam/111_society_27.png": "c45a6bf90c3319b455d5bb5a1eb9a358",
"assets/assets/images/exam/111_english_30-32.png": "160589a9fa503273f8133bf00c4b4128",
"assets/assets/images/exam/111_listening_example_1.png": "f41c27ba3465fdade1914f09e3ba9f5a",
"assets/assets/images/exam/111_society_23.png": "fa596ad662e59afca37fee5bee22c741",
"assets/assets/images/exam/111_society_13.png": "c6c831889ed765ea57c87d4048ea5a15",
"assets/assets/images/exam/111_society_3.png": "4943b48a23f14700a0cc97610c576f53",
"assets/assets/images/exam/111_society_15.png": "1bab9d77dfba6b3b8c70d4ceaa0199da",
"assets/assets/images/exam/111_society_26.png": "481720039cb1d6b12e48410b61fca565",
"assets/assets/images/exam/111_society_36.png": "717a54a87e754b53ce78db3b16f0e851",
"assets/assets/images/exam/111_chinese_1.png": "8a02a92807ea67f7bfc84ffe67ab3edb",
"assets/assets/images/exam/111_chinese_36.png": "fa1f1714720030c7b9901000f43e6603",
"assets/assets/images/exam/111_english_27-29.png": "e8aaa7b824aa130ca9da18cc557fc857",
"assets/assets/images/exam/111_society_11.png": "75adc938ec57dae40afc3fad5c9f913c",
"assets/assets/images/exam/111_chinese_11.png": "f7d131aaf7097eb0846b335f3af016fb",
"assets/assets/images/exam/111_society_52-54.png": "4dea190931692bc2bc81982f7dce86c5",
"assets/assets/images/exam/111_society_18.png": "69b47cf7f98268671f2d002b76e163e3",
"assets/assets/images/exam/111_english_1.png": "25a30b2df09dc688a29676002651e057",
"assets/assets/images/logo.png": "ff3de03be0b72d00ed03476236e9ef4e",
"assets/assets/config.json": "35e6014bea138b4583d8e4d160965e61",
"assets/assets/audios/exam/111_listening_13.mp3": "b2eac9955786a315d7fdb87bd07954af",
"assets/assets/audios/exam/111_listening_15.mp3": "1c0df5784436777f9ea289973bc1241e",
"assets/assets/audios/exam/111_listening_19.mp3": "3227d01105fd943f78179ad010bd92a0",
"assets/assets/audios/exam/111_listening_6.mp3": "380b20a7ba3cc646a720b47ef1766f89",
"assets/assets/audios/exam/111_listening_11.mp3": "302119752a5a67ee62f715f83c58357c",
"assets/assets/audios/exam/111_listening_7.mp3": "0463659d15c0e0a434a1bb158bdc3734",
"assets/assets/audios/exam/111_listening_example_2.mp3": "91cc0e112fe46d8a160d76a8c91fa157",
"assets/assets/audios/exam/111_listening_12.mp3": "4ab2fdfa95788d66fb28c7697d55d6f2",
"assets/assets/audios/exam/111_listening_21.mp3": "07c6ff045fa13f61e40ed9358710c5f9",
"assets/assets/audios/exam/111_listening_20.mp3": "a104b4179d768c2b46ed803731191888",
"assets/assets/audios/exam/111_listening_17.mp3": "f924982bfa1b154f0fa9cd5e297f80ba",
"assets/assets/audios/exam/111_listening_10.mp3": "d992c6cac8979f7d5a3affc6d2ffa544",
"assets/assets/audios/exam/111_listening_2.mp3": "93450b60ca84b6de6f1416c946dc6797",
"assets/assets/audios/exam/111_listening_5.mp3": "bd7ecf1bc5c31de1db6f15b1978e29a4",
"assets/assets/audios/exam/111_listening_4.mp3": "7be28006cb28b3db7b36e364fcbe0e1c",
"assets/assets/audios/exam/111_listening_8.mp3": "f506927af209b4341dfb3fc9f9323e94",
"assets/assets/audios/exam/111_listening_14.mp3": "d09a40d05decd6bc8ccb5606203482d0",
"assets/assets/audios/exam/111_listening_1.mp3": "648415e142ab9e8c56036d735c6eda68",
"assets/assets/audios/exam/111_listening_3.mp3": "2d1a674cc7915843847b9a4e870dc86c",
"assets/assets/audios/exam/111_listening_example_1.mp3": "a62036f5cf239337a83ee67ccc7acbb2",
"assets/assets/audios/exam/111_listening_example_3.mp3": "19d1ec041adfc3596e06876ff8eb822c",
"assets/assets/audios/exam/111_listening_16.mp3": "36ec9cf0f5f1131f1a315d2a47c00079",
"assets/assets/audios/exam/111_listening_9.mp3": "e80727dd8dcb528bc1bb6a34f45e47c3",
"assets/assets/audios/exam/111_listening_18.mp3": "9860753366de48f45bfed55fcdfea6d7",
"assets/AssetManifest.bin": "2673b0d3caea5bfa30d0019eeb242c08",
"privacy.html": "c3fb32b427f0ec50ae1929578ee8c78c"};
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
