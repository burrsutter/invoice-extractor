
## ai-invoice-extractor

## Get PDFs

```
curl -o invoices.zip https://prod-dcd-datasets-cache-zipfiles.s3.eu-west-1.amazonaws.com/tnj49gpmtz-1.zip
```

#### Create a temporary directory
```
temp_dir=$(mktemp -d)
```

#### Extract the zip file into the temporary directory
```
unzip invoices.zip -d "$temp_dir"
```

#### Move the contents from the top-level directory to the current directory
```
mv "$temp_dir/Samples of electronic invoices/"* ./invoices/
```

#### Remove the temporary directory
```
rm -r "$temp_dir"
```

## Setup

### Minio

```
brew install minio/stable/minio
```

```
mkdir ~/minio-data
```

```
minio server ~/minio-data --console-address :9001
```

```
open http://localhost:9001
```

Default
user: minioadmin
password: minioadmin


```bash
python3.11 -m venv .venv
```

```bash
source .venv/bin/activate
```

```bash
pip install -r requirements.txt
```



## Run

### Local Development

```bash
python3.11 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

```bash
python invoice_extractor.py
```

```bash
mc alias set minio http://localhost:9000 minioadmin minioadmin
```

```bash

```

```bash
mc cp myminio/invoices/source/invoice_2.pdf myminio/invoices/intake/
```

```bash
mc cp myminio/invoices/json/invoice_2.json .
```

### Docker Container

Build the Docker image:

```bash
docker build -t invoice-extractor:latest .
```

Run the container locally:

```bash
docker run -d \
  --name invoice-extractor \
  -e S3_ENDPOINT_URL=http://host.docker.internal:9000 \
  -e S3_ACCESS_KEY_ID=minioadmin \
  -e S3_SECRET_ACCESS_KEY=minioadmin \
  -e POLL_INTERVAL=5 \
  invoice-extractor:latest
```


### Kubernetes Deployment

#### Prerequisites

- Kubernetes cluster
- Helm installed
- Minio deployed in the cluster or accessible from the cluster

#### Deploy using Helm

1. Update the values in `helm/invoice-extractor/values.yaml` if needed

2. Install the Helm chart:

```bash
helm install invoice-extractor ./helm/invoice-extractor
```

3. Verify the deployment:

```bash
kubectl get pods -l app.kubernetes.io/name=invoice-extractor
```

#### Customizing the Deployment

You can override values when installing:

```bash
helm install invoice-extractor ./helm/invoice-extractor \
  --set image.repository=your-registry/invoice-extractor \
  --set image.tag=your-tag \
  --set minio.accessKey=your-access-key \
  --set minio.secretKey=your-secret-key \
  --set env[0].value=your-custom-value
```

#### Uninstalling

```bash
helm uninstall invoice-extractor
```
