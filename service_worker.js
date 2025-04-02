// Install event - Cache essential files
self.addEventListener("install", (event) => {
  console.log("Service Worker Installed");

  event.waitUntil(
      caches.open("ecommerce-store-cache").then((cache) => {
          return cache.addAll([
              "/",
              "/index.html",
              "/main.dart.js",
              "/favicon.png",
              "/manifest.json"
          ]);
      })
  );
});

// Activate event - Clean up old caches
self.addEventListener("activate", (event) => {
  console.log("Service Worker Activated");
  event.waitUntil(
      caches.keys().then((cacheNames) => {
          return Promise.all(
              cacheNames.map((cache) => {
                  if (cache !== "ecommerce-store-cache") {
                      console.log("Deleting Old Cache:", cache);
                      return caches.delete(cache);
                  }
              })
          );
      })
  );
});

// Fetch event - Serve cached files when offline
self.addEventListener("fetch", (event) => {
  console.log("Fetching:", event.request.url);

  event.respondWith(
      caches.match(event.request).then((response) => {
          return response || fetch(event.request);
      })
  );
});

// Sync event - Background sync when network is back
self.addEventListener("sync", (event) => {
  if (event.tag === "sync-cart") {
      console.log("Syncing Cart Data...");
      event.waitUntil(syncCartData());
  }
});

// Function to simulate cart data sync
async function syncCartData() {
  return new Promise((resolve) => {
      setTimeout(() => {
          console.log("Cart data synced successfully!");
          resolve();
      }, 2000);
  });
}

// Push event - Receive and display push notifications
self.addEventListener("push", (event) => {
  console.log("Push Notification Received:", event.data ? event.data.text() : "No Payload");

  const options = {
      body: event.data ? event.data.text() : "New product updates available!",
      icon: "/favicon.png",
      badge: "/favicon.png"
  };

  event.waitUntil(
      self.registration.showNotification("E-commerce Store", options)
  );
});
