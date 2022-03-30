---
layout: post
title:  "Neo4j Websocket Connection Failure"
date:   2022-03-29
categories: neo4j
tags: neo4j websocket cypher-shell
---

##### *from [GitHub: Windows Terminal Issue 5420][github-5420], [GitHub: Windows Terminal Issue 5256][github-5256]

## Synopsis
Upon pressing `Connect` in the Neo4j web interface, the following message is displayed:
```
ServiceUnavailable: WebSocket connection failure. Due to security constraints in your web browser, the reason for the failure is not available to this Neo4j Driver. Please use your browsers development console to determine the root cause of the failure. Common reasons include the database being unavailable, using the wrong connection URL or temporary network problems. If you have enabled encryption, ensure your browser is configured to trust the certificate Neo4j is configured to use. WebSocket `readyState` is: 3
```

Multiple solutions are proposed by the Neo4j team and elsewhere usually involve manipulating configuration files. Solutions presented below have not been mentioned anywhere.

## Possible Solutions

1. Bad cookies.  
    Try connecting to the database in the incognito mode, and if that works, clear the site for the domain.
    
2. Expired TLS certificate.  
    Neo4j has a separate directory for the the TLS certificates, and they have to be identical to the ones issued for the domain.  
    Unlike in previous versions, in Neo4j 4+ runs as a service, and its files and directories are decentralized.  
    Certificates to be updated are in `/var/lib/neo4j/certificates`  
    For `letsencrypt`, you can use the following script (replace `YOUR-DOMAIN-NAME` and inspect the paths for correctness):  
    ```bash
    #!/usr/bin/env bash

    pkeysrc="/etc/letsencrypt/live/YOUR-DOMAIN-NAME/privkey.pem"
    certsrc="/etc/letsencrypt/live/YOUR-DOMAIN-NAME/fullchain.pem"
    pkeydst="/var/lib/neo4j/certificates/neo4j.key"
    certdst="/var/lib/neo4j/certificates/neo4j.cert"

    update() {
        echo "updating certificates..."
        cp $pkeysrc $pkeydst
        cp $certsrc $certdst
        systemctl restart neo4j
    }

    diff $pkeysrc $pkeydst 2>&1 > /dev/null || update
    ```

## Additional Considerations
Access to cypher shell may be hampered as well. A default `cypher-shell` command may yield this:
```
Connection to the database terminated. Please ensure that your database is listening on the correct host and port and that you have compatible encryption settings both on Neo4j server and driver. Note that the default encryption setting has changed in Neo4j 4.0.
```

This is because Neo4j 4+ handles the encryption information differently (and more strictly) compared to the previous versions. To launch cypher shell for an Neo4j app running with encryption, one has to specify the [URI scheme][neo4j-uri-scheme], the application address, and the correct `bolt` port.  
There are two possible options:  
1. The advertised address (secured with full certificate):
    ```bash
    cypher-shell -a neo4j+s//:YOUR-DOMAIN-NAME:7687
    ```
2. Localhost (secured with self-signed certificate):
    ```bash
    cypher-shell -a neo4j+ssc//:localhost:7687
    ```

[neo4j-uri-scheme]: https://neo4j.com/docs/java-manual/current/client-applications/#java-driver-configuration-examples