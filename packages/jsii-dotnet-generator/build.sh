#!/bin/bash
set -euo pipefail

npm run gen

# TODO: Auto-rev NuGet package versions on each local build.
# Because we we don't rev the versions, dotnet will pick
# up an old build from the cache if it exists. So we
# explicitly clear the cache as a temporary workaround.
dotnet nuget locals all --clear
dotnet build -c Release ./src/Amazon.JSII.Generator.sln
dotnet publish -c Release src/Amazon.JSII.Generator.CLI/

mkdir -p cli
rsync -av ./src/Amazon.JSII.Generator.CLI/bin/Release/netcoreapp2.0/ ./cli/

cp -f ./bin/Release/NuGet/*.nupkg .
