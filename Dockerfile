FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS bace
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["web1.csproj", "./"]
RUN dotnet restore "./web1.csproj"
COPY . .
WORKDIR /src./
RUN dotnet build "./web1.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "./web1.csproj" -c Release -o /app/publish
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "web1.dll" ]