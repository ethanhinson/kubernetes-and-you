FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 5000
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["WeatherTest.csproj", "./"]
RUN dotnet restore "/src/WeatherTest.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "WeatherTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WeatherTest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY .docker/nginx /etc/nginx
ENTRYPOINT ["dotnet", "WeatherTest.dll"]