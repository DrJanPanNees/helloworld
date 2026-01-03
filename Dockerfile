# Stage 1: build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /out

# Stage 2: runtime
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime
WORKDIR /app
COPY --from=build /out ./
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD [ "dotnet", "HelloWorld.dll" ]
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
