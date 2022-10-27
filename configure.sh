#!/bin/bash

#rm cloud-formation.yml
#rm README.md
#rm -rf .git
#rm .git

chmod +x purge.sh
chmod +x env.sh

chmod +x shim/build-all.sh
chmod +x shim/load-all.sh
chmod +x shim/unload-all.sh
chmod +x shim/publish-all.sh

chmod +x workshop/build-all.sh
chmod +x workshop/load-all.sh
chmod +x workshop/unload-all.sh

chmod +x workshop/00-proxy/load.sh
chmod +x workshop/00-proxy/unload.sh

chmod +x workshop/00-workshop-instructions/load.sh
chmod +x workshop/00-workshop-instructions/unload.sh

chmod +x workshop/01-build-and-package/load.sh
chmod +x workshop/01-build-and-package/unload.sh

chmod +x workshop/02-deploy-rollback/load.sh
chmod +x workshop/02-deploy-rollback/unload.sh








chmod +x workshop/10-jenkins/load.sh
chmod +x workshop/10-jenkins/unload.sh
