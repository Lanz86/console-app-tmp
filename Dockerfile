FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source

RUN git clone https://github.com/Lanz86/CleanArchitecture.git
# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# copy and publish app and libraries
COPY . .
RUN dotnet publish -c Release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Template.dll"]