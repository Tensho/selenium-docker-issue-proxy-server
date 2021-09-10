# selenium-docker-issue-proxy-server

1. Clone git repo:
```
$ git clone git@github.com:Tensho/selenium-docker-issue-proxy-server.git
$ cd selenium-docker-issue-proxy-server
```
2. Look around the Docker composition.
3. Check out git branch with enabled `HTTP(S)_PROXY` env var and disabled `proxy:` option:
```
$ git checkout http_proxy_env_var
```
4. Run Docker composition:
```
$ docker-compose up
```
5. Make sure  HTTP requests to https://github.com run through `mitmproxy` service and have `foo: bar` header:
```
...
mitmproxy_1        | 172.27.0.3:51070: GET https://github.com/ HTTP/2.0
mitmproxy_1        |     sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"
mitmproxy_1        |     sec-ch-ua-mobile: ?0
mitmproxy_1        |     upgrade-insecure-requests: 1
mitmproxy_1        |     user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36
mitmproxy_1        |     accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
mitmproxy_1        |     sec-fetch-site: none
mitmproxy_1        |     sec-fetch-mode: navigate
mitmproxy_1        |     sec-fetch-user: ?1
mitmproxy_1        |     sec-fetch-dest: document
mitmproxy_1        |     accept-encoding: gzip, deflate, br
mitmproxy_1        |     accept-language: en-US,en;q=0.9
mitmproxy_1        |     foo: bar
mitmproxy_1        |  << HTTP/2.0 200 OK 44.32k
...
^C
```
Everything works as expected – HTTP requests are passed through proxy and headers are modified.

6. Check out git branch with disabled `HTTP(S)_PROXY` env var and enabled `proxy:` option:
```
$ git checkout selenium_driver_proxy_option
```
7. Run Docker composition:
```
$ docker-compose up
```
8. Make sure  HTTP requests to https://github.com **don't** run through `mitmproxy` service and hence don't have `foo: bar` header:
```
...
selenium-chrome_1  | 09:11:39.359 INFO [LocalDistributor.newSession] - Session created by the distributor. Id: 134c9b85c67f1b562e592cebb233679f, Caps: Capabilities {acceptInsecureCerts: false, browserName: chrome, browserVersion: 92.0.4515.131, chrome: {chromedriverVersion: 92.0.4515.107 (87a818b10553..., userDataDir: /tmp/.com.google.Chrome.CbXSg5}, goog:chromeOptions: {debuggerAddress: localhost:44645}, networkConnectionEnabled: false, pageLoadStrategy: normal, platformName: linux, proxy: Proxy(manual, http=selenium..., se:cdp: ws://172.27.0.3:4444/sessio..., se:cdpVersion: 92.0.4515.131, se:vnc: ws://172.27.0.3:4444/sessio..., se:vncEnabled: true, se:vncLocalAddress: ws://localhost:7900/websockify, setWindowRect: true, strictFileInteractability: false, timeouts: {implicit: 0, pageLoad: 300000, script: 30000}, unhandledPromptBehavior: dismiss and notify, webauthn:extension:credBlob: true, webauthn:extension:largeBlob: true, webauthn:virtualAuthenticators: true}
client_1           | https://github.com/
selenium-docker-issue-proxy-server_client_1 exited with code 0
^C
```
