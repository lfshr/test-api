FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

COPY *.sln .
COPY test-api/*.csproj ./test-api/
RUN dotnet restore

COPY test-api/. ./test-api/
WORKDIR /app/test-api
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/test-api/out ./
ENTRYPOINT ["dotnet", "test-api.dll"]
