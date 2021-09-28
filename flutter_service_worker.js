'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "CNAME": "0ab8e3df32a0cc042dd9e1e3dbad333e",
"favicon.png": "d00c17941bfd857e9af8d02cc5caafd4",
"index.html": "dd685669140f13fb81f0b7bc20fd9ead",
"/": "dd685669140f13fb81f0b7bc20fd9ead",
"assets/NOTICES": "e1499bfd8aa19aa4db30789ba5f92b89",
"assets/assets/images/default-yellow.webp": "c4f05ba744c9b274b9630fe834f66895",
"assets/assets/images/github.svg": "84b553e05df0f65425f3952d2c2778cd",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/AssetManifest.json": "5b6afd466784bc67d0d1b650dc8aec51",
"version.json": "c2d6d318d66ad12dc46c8962b9a0ff98",
"manifest.json": "20e1cef289b5e3d9e4a8348d451ee152",
"icons/favicon-16x16.png": "903b461028865af14e5a4d0c474c9965",
"icons/apple-icon-76x76.png": "7b8b543bf577b6bc21d4124bb89515fe",
"icons/android-icon-36x36.png": "872d0dbbcccc06b3a02e89efe049631f",
"icons/apple-icon-114x114.png": "4c62e22e631880c1ea7a9b46a7e0071f",
"icons/Icon-512.png": "02052de952beb3c58bc2b96f79293f67",
"icons/apple-icon-144x144.png": "b1a64b9ea1daa861457385f766069f11",
"icons/apple-icon-57x57.png": "7684659cea175e7fd88831443b100e91",
"icons/android-icon-192x192.png": "2c7351d5c8298f43491d02cedba0421a",
"icons/apple-icon.png": "9a7d9c5214adbc59dcce471f05b0c421",
"icons/apple-icon-precomposed.png": "9a7d9c5214adbc59dcce471f05b0c421",
"icons/android-icon-144x144.png": "b1a64b9ea1daa861457385f766069f11",
"icons/android-icon-72x72.png": "384fc5ab12abed20d88bce6aa35b575f",
"icons/ms-icon-70x70.png": "980ba3698695f99122fed47b2f37e8d9",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/favicon.ico": "b2951712919b7ab05811fdbad8eaf30b",
"icons/android-icon-48x48.png": "8add7b6dac885ddc6c06724eff953f20",
"icons/favicon-32x32.png": "47c08608a7a2d238f80be002eaf17ea1",
"icons/apple-icon-60x60.png": "076f567e1074d913792366cbc3fbc391",
"icons/apple-icon-152x152.png": "0f6b02921c669c7772f77256448640e2",
"icons/Icon-192.png": "e913fa298a0be4c9f7d95f1e8e75511b",
"icons/android-icon-96x96.png": "190beb4e79e27a5c1a39cf537bf299a4",
"icons/ms-icon-144x144.png": "b1a64b9ea1daa861457385f766069f11",
"icons/ms-icon-310x310.png": "57720ccfbe2b1aa31faf8d5f04b02b64",
"icons/favicon-96x96.png": "190beb4e79e27a5c1a39cf537bf299a4",
"icons/apple-icon-72x72.png": "384fc5ab12abed20d88bce6aa35b575f",
"icons/ms-icon-150x150.png": "829066e14d6d1c3786b7b38d4de4eb2e",
"icons/apple-icon-180x180.png": "ed57b345a89e9e97cd3a50ced268e2b6",
"icons/apple-icon-120x120.png": "ec05c7620ff2734e1ef86cbc577f42fa",
"main.dart.js": "767d21edecb5e5c5dedc0a537faccf00"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
