# dotnet-citool-test

Sample application to validate the following CI tools:
- GitHub Actions
- CloudBees
- CircleCI

# MyWebApp Blazor WebAssembly Application

[![CI Pipeline for MyWebApp Client](https://github.com/[YOUR_GITHUB_USERNAME]/[YOUR_REPO_NAME]/actions/workflows/ci-pipeline.yml/badge.svg)](https://github.com/[YOUR_GITHUB_USERNAME]/[YOUR_REPO_NAME]/actions/workflows/ci-pipeline.yml)

A Blazor WebAssembly application with CI/CD pipeline using GitHub Actions.

## CI/CD Pipeline

This project includes a GitHub Actions workflow that automatically:

1. **Builds** the application
2. **Tests** the application using the test project
3. **Creates** a Docker container image
4. **Publishes** the container to JFrog Artifactory

### Workflow Details

The workflow is defined in `.github/workflows/ci-pipeline.yml` and is triggered:
- On pushes to all branches
- On pull requests to all branches
- Manually via the GitHub Actions UI

## Versioning

The project uses semantic versioning (SemVer) in the format `MAJOR.MINOR.PATCH.BUILD`:

- Base version is defined in `Directory.Build.props`
- Build number from GitHub Actions run number is automatically appended
- Docker images are tagged with `v{VERSION}` (e.g., `v1.0.0.42`)
- A `latest` tag is also applied to the most recent successful build

### Managing Versions

To update the version manually:
# Increment patch version (1.0.0 -> 1.0.1)
./update-version.ps1 -Increment patch

# Increment minor version (1.0.0 -> 1.1.0)
./update-version.ps1 -Increment minor

# Increment major version (1.0.0 -> 2.0.0)
./update-version.ps1 -Increment major

# Set specific version
./update-version.ps1 -Version 3.2.1
## Required GitHub Repository Settings

For the workflow to function properly:

1. Ensure GitHub Actions is enabled in your repository settings
2. Set up the JFrog Artifactory credentials:
   - Set `JF_URL` as a GitHub repository variable
   - Set `JF_ACCESS_TOKEN` as a GitHub repository secret

## Local Development

To run the application locally:cd MyWebApp.Client
dotnet run
To run tests:cd Tests/MyWebApp.Client.Tests
dotnet test
## Building the Docker Image Locallydocker build -t mywebapp-client -f MyWebApp.Client/Dockerfile .
docker run -p 8080:80 mywebapp-client
