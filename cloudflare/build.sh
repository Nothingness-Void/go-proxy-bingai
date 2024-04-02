#!/bin/bash

cp -r web cloudflare/web

rm cloudflare/web/web.go
rm -rf go-proxy-bingai

shopt -s extglob
rm -rf !(cloudflare)
mv cloudflare/* .
rm -rf cloudflare build.sh

sed -i "s/if (currentUrl.pathname === '\/' || currentUrl.pathname.indexOf('\/web\/') === 0) {/if (currentUrl.pathname === '\/') {/g" worker.js
sed -i "s/return home(currentUrl.pathname);/let res = new Response('', {\n        status: 302,\n      });\n      res.headers.set('location', '\/web\/');\n      return res;\n    }\n    if (currentUrl.pathname.indexOf('\/web\/') === 0) {\n      return env.ASSETS.fetch(request);/g" worker.js

mv worker.js _worker.js