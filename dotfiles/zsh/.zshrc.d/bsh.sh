#!/bin/bash
CDS_PASSWORD="yDKucgNJc6Fj"
alias discovery_mwa_prod="docker-compose up -d && npm run build && CDS_BASEPATH=https://gateway.val.homeconnectgw.com CDS_PASSWORD=$CDS_PASSWORD HC_API_URL=https://api.home-connect.com/api HCA_URL=https://rt.homeconnecthca.com:443 LOG_LEVEL=DEBUG npm run start"
alias discovery_mwa_val="docker-compose up -d && npm run build && CDS_BASEPATH=https://gateway.val.homeconnectgw.com CDS_PASSWORD=$CDS_PASSWORD HC_API_URL=https://api.home-connect.com/api HCA_URL=https://web-bsh-bshservices-test.aw.atos.net:443 LOG_LEVEL=DEBUG npm run start"
alias discovery_mwa_qual="docker-compose up -d && npm run build && CDS_BASEPATH=https://gateway.val.homeconnectgw.com CDS_PASSWORD=$CDS_PASSWORD HC_API_URL=https://api.home-connect.com/api HCA_URL=https://qlf-bshservices.aw.atos.net:443 LOG_LEVEL=DEBUG npm run start"
alias discovery_mwa_val_mocked="docker-compose up -d && npm run build && HC_API_URL=https://api.home-connect.com/api HCA_URL=https://web-bsh-bshservices-test.aw.atos.net:443 LOG_LEVEL=DEBUG npm run start"

