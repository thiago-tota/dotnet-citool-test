# dotnet-citool-test

Sample application to validade the following CI tools:
- GitHub Actions
- CloudBees
- CircleCI

# MyWebApp Blazor WebAssembly Application

[![Build, Test and Deploy](https://github.com/[YOUR_GITHUB_USERNAME]/[YOUR_REPO_NAME]/actions/workflows/build-test-deploy.yml/badge.svg)](https://github.com/[YOUR_GITHUB_USERNAME]/[YOUR_REPO_NAME]/actions/workflows/build-test-deploy.yml)

A Blazor WebAssembly application with CI/CD pipeline using GitHub Actions.

## CI/CD Pipeline

This project includes a GitHub Actions workflow that automatically:

1. **Builds** the application
2. **Tests** the application using the test project
3. **Creates** a Docker container image
4. **Publishes** the container to GitHub Container Registry (GHCR)

### Workflow Details

The workflow is defined in `.github/workflows/build-test-deploy.yml` and is triggered:
- On pushes to the `main` branch
- On pull requests to the `main` branch
- Manually via the GitHub Actions UI

### Accessing the Container Image

After the workflow runs successfully, the container image will be available at:
ghcr.io/[YOUR_GITHUB_USERNAME]/mywebapp-client:latest
To pull the image, use:
docker pull ghcr.io/[YOUR_GITHUB_USERNAME]/mywebapp-client:latest
### Running the Container Locally
docker run -p 8080:80 ghcr.io/[YOUR_GITHUB_USERNAME]/mywebapp-client:latest
Then access the application at http://localhost:8080

## Required GitHub Repository Settings

For the workflow to function properly:

1. Ensure GitHub Actions is enabled in your repository settings
2. Make sure the `GITHUB_TOKEN` has write permissions for packages:
   - Go to Settings ? Actions ? General ? Workflow permissions
   - Select "Read and write permissions"

## Local Development

To run the application locally:
cd MyWebApp.Client
dotnet run
To run tests:
cd Tests/MyWebApp.Client.Tests
dotnet test
## Building the Docker Image Locally
docker build -t mywebapp-client -f MyWebApp.Client/Dockerfile .
docker run -p 8080:80 mywebapp-client
