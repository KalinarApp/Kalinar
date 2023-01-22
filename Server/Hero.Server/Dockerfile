FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["nuget.config", "."]
COPY ["Hero.Server/Hero.Server.csproj", "Hero.Server/"]
COPY ["Hero.Server.Core/Hero.Server.Core.csproj", "Hero.Server.Core/"]
COPY ["Hero.Server.Identity/Hero.Server.Identity.csproj", "Hero.Server.Identity/"]
COPY ["Hero.Server.DataAccess/Hero.Server.DataAccess.csproj", "Hero.Server.DataAccess/"]
RUN dotnet restore "Hero.Server/Hero.Server.csproj"
COPY . .
WORKDIR "/src/Hero.Server"
RUN dotnet build "Hero.Server.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Hero.Server.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Hero.Server.dll"]
