
# firebase-emulator-suite

## usage

start by generating a ci token with `firebase login:ci` and keep this aside for later.

ensure you've got a `firebase.json` file for instructing the emulator suite which emulators to use.

example `firebase.json`:
```json
{
  "emulators": {
    "firestore": {
      "enabled": true,
      "port": "8080",
      "host": "0.0.0.0"
    },
    "ui": {
      "enabled": true,
      "port": "4000",
      "host": "0.0.0.0"
    },
    "auth": {
      "enabled": true,
      "port": "9099",
      "host": "0.0.0.0"
    }
  }
}
```

link everything together in a `docker-compose.yml`:

```yaml
firebase:
  image: ghcr.io/io-digital/firebase-emulator-suite
  environment:
    - FIREBASE_TOKEN=YOUR_FIREBASE_CI_TOKEN
    - FIREBASE_PROJECT=YOUR_FIREBASE_PROJECT_NAME
  volumes:
    - ./path/to/keep/cached/firebase/emulators:/home/firebase/.cache/
    - ./path/to/your/firebase.json:/home/firebase/firebase.json
  ports:
    - '9099:9099'
    - '4000:4000'
    - '5001:5001'
    - '9000:9000'
    - '8080:8080'
    - '8085:8085'
    - '5000:5000'
```

take note of:

* the port mappings, which have to match your assigned ports in `firebase.json`
* the volume mappings, paying special attention to:
  + volume `/home/firebase/.cache` will prevent re-downloading of individual firebase emulators every time the container is restarted
  + volume `/home/firebase/firebase.json` will not only configure **which** emulators run, but also configure the host/container networking as long as each emulator host is set to `0.0.0.0`
* the environment variables, which include your firebase token generated earlier with `firebase login:ci`

with all of the above in place, bring up the docker-compose system as normal.

you will notice on the first build/run that the firebase-emulator-suite will not respond for a while. this is normal, it is downloading the emulators.

eventually, it will print to stdout indicating that the emulators are live along with a link for opening the emulator control-plane in your browser.

this download step will only occur once, provided the cache volume was not invalidated or more emulators were configured in `firebase.json` to be run that have not yet been downloaded.
