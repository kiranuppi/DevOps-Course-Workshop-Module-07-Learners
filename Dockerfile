FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
USER root
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs
WORKDIR /app/

# copy csproj and restore as distinct layers
COPY *.sln .
COPY DotnetTemplate.Web/*.csproj ./DotnetTemplate.Web/
COPY DotnetTemplate.Web.Tests/*.csproj ./DotnetTemplate.Web.Tests/
RUN dotnet restore

COPY DotnetTemplate.Web/. ./DotnetTemplate.Web/
WORKDIR /app/DotnetTemplate.Web/
# RUN npm rebuild node-sass --force
RUN dotnet publish -c release -o /app/release

FROM mcr.microsoft.com/dotnet/aspnet:latest 
WORKDIR /app/
COPY --from=build /app/release ./
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]