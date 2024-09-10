using Azure.Identity;
using POAB.Api.Extensions;

WebApplicationBuilder builder = WebApplication
    .CreateBuilder(
        args
    );

builder
    .Configuration
    .AddApplicationConfiguration();

builder
    .Services
    .AddApplicationServices();

WebApplication app = builder
    .Build();

app
    .AddApplicationMiddleware();

app.Run();
