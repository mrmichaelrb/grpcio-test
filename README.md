# grpcio-test
Example of Python grpcio Access Violation (segfault) in Python under Wine in a Kubernetes Container on Google Cloud Platform

The issue was reported at:
[https://github.com/grpc/grpc/issues/34879](https://github.com/grpc/grpc/issues/34879)

To run this test example:
1. Build the image from the Dockerfile (using GCP's Cloud Build)
2. Deploy the image as a workload to Kubernetes (using GCP's Kubernetes Engine)
3. View the logs of the workload in Kubernetes and see the access violation

The secret `"test-secret"` does not have to exist in the Secret Manager of the GCP project to demonstrate the access violation, but if the bug is fixed, the test script in this container will not succeed (and print out the secret) unless the secret exists.
