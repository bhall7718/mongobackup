#This script assumes the above ENV variables ahave been set on container start via individual
# -e entries or by referencing an env.list file via --env-file.

echo "Logging into Azure using a service principle..."
az login \
    --service-principal \
    -u $SP_USER \
    -p $SP_PASS \
    --tenant $TENANT_ID

echo "Attempting to create a container labled 'backup' if one does not already exist."
az storage container create \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY \
    --name $CONTAINER

echo "Setting up a backup FileName based on today's date."
FILEPATH="/home/"
FILENAME=`date '+%Y-%m-%d-%H-%M-%S'`.gz;

echo "Backing up the Mongo database, compressing it via gzip, then saving it to the local machine."
mongodump \
    --host $MONGO_HOST \
    --port $MONGO_PORT \
    --username $MONGO_USER \
    --password $MONGO_PASS \
    --archive \
    --gzip \
    --ssl \
    | $FILEPATH$FILENAME

echo "Pushing the gzipped backup file into Azure Blob Storage under the backup container."
az storage blob upload \
    --file $FILEPATH$FILENAME \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY \
    --container-name $CONTAINER \
    --content-encoding gzip \
    --name $FILENAME

echo "Logging out of Azure."
az logout

echo "Cleaning up the gzipped file on the local machine image."
rm $FILEPATH$FILENAME