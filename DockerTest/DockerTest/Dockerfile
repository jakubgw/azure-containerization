FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base

LABEL mainteiner="jakub.gwozdz@avanade.com"

WORKDIR /app
EXPOSE 63374
EXPOSE 44300

FROM microsoft/dotnet:2.1-sdk AS build
ADD . /src
COPY ["DockerTest.csproj", "DockerTest/"]
RUN dotnet restore "DockerTest/DockerTest.csproj"

WORKDIR /src
RUN dotnet build "DockerTest.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DockerTest.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DockerTest.dll"]