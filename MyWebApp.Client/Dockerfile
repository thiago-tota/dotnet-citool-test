# See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

# This stage is used when running from VS in fast mode (Default for Debug configuration)

# Base image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Install ICU libraries and set globalization invariant environment variable
RUN apk add --no-cache icu-libs
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

USER app

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy the project file
COPY ["MyWebApp.Client/MyWebApp.Client.csproj", "MyWebApp.Client/"]

# Restore dependencies
RUN dotnet restore "./MyWebApp.Client/MyWebApp.Client.csproj"

# Copy all the source code to the container
COPY . .

# Set the working directory for building the WebAssembly project
WORKDIR "/src/MyWebApp.Client"

# Publish the project
RUN dotnet publish "./MyWebApp.Client.csproj" -c $BUILD_CONFIGURATION --no-restore -o /app/publish

# Final stage - use Nginx to serve the static WebAssembly files
FROM nginx:alpine AS final
WORKDIR /usr/share/nginx/html

# Copy the published files to Nginx serve directory
COPY --from=build /app/publish/wwwroot /usr/share/nginx/html

# Copy our custom nginx configuration
COPY ["MyWebApp.Client/nginx.conf", "/etc/nginx/nginx.conf"]

# Expose port 80
EXPOSE 80

# Optional: Healthcheck for the container
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1