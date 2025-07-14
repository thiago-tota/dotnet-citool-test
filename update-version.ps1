param (
    [Parameter(Mandatory = $false)]
    [ValidatePattern("^\d+\.\d+\.\d+$")]
    [string]$Version,
    
    [Parameter(Mandatory = $false)]
    [ValidateSet("major", "minor", "patch")]
    [string]$Increment = "patch"
)

# If no version is specified, read from Directory.Build.props
if (-not $Version) {
    $buildPropsContent = Get-Content -Path "Directory.Build.props" -Raw
    if ($buildPropsContent -match '<VersionPrefix>(\d+\.\d+\.\d+)<\/VersionPrefix>') {
        $currentVersion = $matches[1]
        Write-Host "Current version: $currentVersion"
        
        # Parse version components
        $versionParts = $currentVersion -split '\.'
        $major = [int]$versionParts[0]
        $minor = [int]$versionParts[1]
        $patch = [int]$versionParts[2]
        
        # Increment based on parameter
        switch ($Increment) {
            "major" {
                $major++
                $minor = 0
                $patch = 0
            }
            "minor" {
                $minor++
                $patch = 0
            }
            "patch" {
                $patch++
            }
        }
        
        $Version = "$major.$minor.$patch"
    }
    else {
        Write-Error "Could not find version in Directory.Build.props"
        exit 1
    }
}

Write-Host "Setting version to: $Version"

# Update Directory.Build.props
$buildPropsContent = Get-Content -Path "Directory.Build.props" -Raw
$updatedContent = $buildPropsContent -replace '<VersionPrefix>\d+\.\d+\.\d+<\/VersionPrefix>', "<VersionPrefix>$Version</VersionPrefix>"
$updatedContent | Set-Content -Path "Directory.Build.props" -NoNewline

Write-Host "Version updated to $Version in Directory.Build.props"

# Optional: Create a git tag for this version
$createTag = Read-Host "Create git tag for version v$Version? (y/n)"
if ($createTag -eq "y") {
    git tag -a "v$Version" -m "Version $Version"
    Write-Host "Git tag v$Version created. Push with: git push origin v$Version"
}