from google.cloud import secretmanager
import time
from urllib import request

GCP_PROJECT_ID_META_URL = (
    "http://metadata.google.internal/computeMetadata/v1/project/project-id"
)

TEST_SECRET = "test-secret"

print("Getting the GCP project ID")
project_id_request = request.Request(GCP_PROJECT_ID_META_URL)
project_id_request.add_header("Metadata-Flavor", "Google")
gcp_project_id = request.urlopen(project_id_request).read().decode()

print("Getting the secret")
gcp_secret_manager_client = secretmanager.SecretManagerServiceClient()
secret_path = gcp_secret_manager_client.secret_version_path(
    gcp_project_id, TEST_SECRET, "latest"
)
response = gcp_secret_manager_client.access_secret_version(name=secret_path)
secret = response.payload.data.decode("UTF-8")
print(f"The secret is: {secret}")

print("Done")
time.sleep(10000000)
