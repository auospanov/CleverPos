FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY CleverPos.License.Core/CleverPos.License.Core.csproj CleverPos.License.Core/
COPY CleverPos.License.Api/CleverPos.License.Api.csproj CleverPos.License.Api/
RUN dotnet restore CleverPos.License.Api/CleverPos.License.Api.csproj

COPY CleverPos.License.Core/ CleverPos.License.Core/
COPY CleverPos.License.Api/ CleverPos.License.Api/
RUN dotnet publish CleverPos.License.Api/CleverPos.License.Api.csproj -c Release -o /app /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app ./
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "CleverPos.License.Api.dll"]
