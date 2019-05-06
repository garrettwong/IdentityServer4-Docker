#!/bin/sh

dotnet --version
dotnet new webapi

dotnet dev-certs https
dotnet restore

