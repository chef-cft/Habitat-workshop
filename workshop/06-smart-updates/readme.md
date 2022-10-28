# transactional

A demo asp.net core app that can be updated but will block stopping if there is an outstanding transaction.

## Running the demo

There should be an 0.1.0 and an 0.2.0 in builder and only 0.1.0 should be in stable.
Load the service via:

```
hab svc load mwrock/transactional --shutdown-timeout 600 --strategy at-once --update-condition track-channel
```

This should run version 0.1.0 of the application accesible from http://localhost:5000/.

Click the "Start Transaction" button.

Promote 0.2.0 to stable in the builder UI.

NOTE: it may take the supervisor 0 - 30 seconds to pull the new version from builder after promoting.

Even though the supervisor will install the new 0.2.0 version, 0.1.0 will not stop until you click the "Complete Transaction" button.

Once you click that button, clicking the "Refresh Application" link should refresh the page and you should see "I am application version 0.2.0" on the page.