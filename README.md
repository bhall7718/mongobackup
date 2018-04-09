# Overview
**Work in Progress...**
## Setup Instructions
1. (**optional**) Pull down the local source into a folder of your choosing. This is optional because you can technically perform a ```docker build``` pointing direct at the GitHub repository if no changes are intended.
2. Create an ```env.list``` file that aligns to your environment. See [Enviornment Variables List section](#environment-variables-list) to learn more.
3. [Build](#docker-build-examples), [Run](#docker-run-examples), and [Start](#docker-start-examples) with Docker

## What's Next for this Project?
The [Roadmap](https://github.com/bhall7718/mongobackup/wiki/Roadmap) is located maintained in this GitHub's wiki section. Please give it a read to see what possible next steps are being considered.

As the community has ideas about what they would like to see on the roadmap, please leave that feedback in this GitHub's Issues section under a ticket labled as a "enhancement".

![enhancement example](https://raw.githubusercontent.com/bhall7718/mongobackup/master/Documentation/Images/feature_request.PNG)

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
Service Principle User will come in the format of a GUID and can be found in Azure Active Directory under application registrations.

![SP_USER Example Image](https://raw.githubusercontent.com/bhall7718/mongobackup/master/Documentation/Images/sp_user.jpg)

## SP_PASS
Service Principle Password is otherwise known as a secret key. This key can be fetched from the **Azure Active Directory**, then **Applicatoin Registrations**, then under the keys blade. It should be noted that the key is only available for viewing uppon the initial creation of the key.

![SP_PASS Example Image](https://raw.githubusercontent.com/bhall7718/mongobackup/master/Documentation/Images/sp_pass.jpg)

## STORAGE_ACCOUNT
This variable is the unique identifier to the Azure Storage Blob resource in which the backups would be saved to. This value can be found in the **Azure Portal** by clicking on the **Azure Storage** resource, then clicking on the **Access Keys** blade.

![STORAGE_ACCOUNT Example Image](https://raw.githubusercontent.com/bhall7718/mongobackup/master/Documentation/Images/storage_account.jpg)

## STORAGE_KEY
This variable is the secret key needed to access the Azure Storage Blob resource in which the backups would be saved to. This value can be found in the **Azure Portal** by clicking on the **Azure Storage** resource, then clicking on the **Access Keys** blade.

![STORAGE_KEY Example Image](https://raw.githubusercontent.com/bhall7718/mongobackup/master/Documentation/Images/storage_key.jpg)

## CONTAINER
This variable is required, but can be set to whatever the developer desires. This is ultimately a folder name to store the backups in.

**Note:** *The container does not need to exist yet, but it will not hurt anything if it does.*

## MONGO_HOST
This is the address at which your MongoDB can be accessed. This could be an endpoint URL, or an IP address. No need to append the port on the end as that is taken care of in the **MONGO_PORT** variable.

## MONGO_PORT
This is the port at which your MongoDB Host is listening on. If you are running MongoDB on CosmosDB then the port would be 10255.

## MONGO_USER
This variable is the MongoDB username which the database will need to execute commands.

## MONGO_DB
This variable is reserved to hold the name of the database that should be backed up.

## MONGO_COLLECTION
This variable is reserved to hold the name of the collection that should be backed up.

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

### Without Terminal Exposed
``` sh
docker run --name mongobackupbox --env-file ./env.list bhall7718/mongobackup
```
### With Terminal Exposed
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