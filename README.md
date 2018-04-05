# Overview
**Work in Progress...**
## Setup Instructions
1. (**optional**) Pull down the local source into a folder of your choosing. This is optional because you can technically perform a ```docker build``` pointing direct at the GitHub repository if no changes are intended.
2. Create an ```env.list``` file that aligns to your environment. See [Enviornment Variables List section](#environment-variables-list) to learn more.
3. [Build](#docker-build-examples), [Run](#docker-run-examples), and [Start](#docker-start-examples) with Docker

## What's Next for this Project?
The [Roadmap](https://github.com/bhall7718/mongobackup/wiki/Roadmap) is located maintained in this GitHub's wiki section. Please give it a read to see what possible next steps are being considered.

# Environment Variables List
This solution contains a file labeled ```example-env.list``` that is just a *template* developers can follow to create their own private ```env.list``` file. Special care should be taken to not share or check-in the private ```env.list```, which is why both the ```.gitignore``` and ```.dockerignore``` files exclude it. The final ```env.list``` file is what would contain all the use-case specific usernames, passwords, host URLs, ports, and everything else needed by the main script found in ```run.sh```.

In this section we will outline what the variable is, and where it can be found in a given Azure subscription.

```
TENANT_ID=...
SP_USER=...
SP_PASS=v...

STORAGE_ACCOUNT=...
STORAGE_KEY=...
CONTAINER=...

MONGO_HOST=...
MONGO_PORT=...
MONGO_USER=...
MONGO_PASS=...
MONGO_DB=...
MONGO_COLLECTION=...
```
## TENANT_ID
Sometimes known by another name, Directory ID. This identifyer marks the directory account in which an  Azure Subscription ties back to. This variable is used in the ```az login --service-principal``` command found in the ```run.sh``` script.

The variable will be a GUID found in the **Azure portal** under **Active Directory**, then under the **Properties** blade. See image below:

![TENANT_ID Example Image](https://raw.githubusercontent.com/bhall7718/mongobackup/master/Documentation/Images/tenant_id.jpg)

## SP_USER
*Work in Progress*
## SP_PASS
*Work in Progress*
## STORAGE_ACCOUNT
*Work in Progress*
## STORAGE_KEY
*Work in Progress*
## CONTAINER
*Work in Progress*
## MONGO_HOST
*Work in Progress*
## MONGO_PORT
*Work in Progress*
## MONGO_USER
*Work in Progress*
## MONGO_DB
*Work in Progress*
## MONGO_COLLECTION
*Work in Progress*

# Docker Build Examples
## Directly from GitHub
``` sh
docker build -t bhall7718/mongobackup https://github.com/bhall7718/mongobackup.git
```
## From a Local Copy of the Source
**Note:** *This example assumes your console path is initialized into the folder containing the source Dockerfile.*
``` sh
docker build -t bhall7718/mongobackup .
```

# Docker Run Examples
**Note:** *These examples assume you have created your own env.list located in the directory your commandline is initialized to. The examples also assume that bhall7718/mongobackup is the tagged name of your built image.*

### With Terminal Exposed
``` sh
docker run --name mongobackupbox --env-file ./env.list bhall7718/mongobackup
```
### Without Terminal Exposed
``` sh
docker run --name mongobackupbox --env-file ./env.list bhall7718/mongobackup -it
```
### Silent Background Execution Mode (detached)
``` sh
docker run --name mongobackupbox --env-file ./env.list bhall7718/mongobackup -d
```

# Docker Start Examples
**Note:** *These examples assume you have named your image "mongobackupbox" as outlined in the docker run examples above. If you have chosen a different name simply adjust accordingly.*

### With Terminal Exposed
``` sh
docker start mongobackupbox -i
```
### Without Terminal Exposed
``` sh
docker start mongobackupbox
```
