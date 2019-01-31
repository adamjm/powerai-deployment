## VPN Run command
docker build -f Dockerfile -t openconnect .
docker run --cap-add NET_ADMIN -e PASSWORD=<password> -e USER=<username> -e CERT=<cert> -p 35455:35455 -p 35454:35454 -it openconnect /bin/bash
