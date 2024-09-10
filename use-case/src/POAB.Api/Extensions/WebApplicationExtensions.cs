using POAB.Api.Services.Info;

namespace POAB.Api.Extensions;

public static class WebApplicationExtensions
{
    public static WebApplication AddApplicationMiddleware(
        this WebApplication app    
    )
    {
        app
            .AddDevelopmentMiddleware()
            .AddRoutes();

        return app;
    }

    private static WebApplication AddDevelopmentMiddleware(
        this WebApplication app    
    )
    {
        app
            .UseSwagger();

        app
            .UseSwaggerUI();

        return app;
    }

    private static WebApplication AddRoutes(
        this WebApplication app    
    )
    {
        app
            .MapGet(
                "/api/info",
                (
                    InfoService infoService
                ) =>
                {
                    return infoService
                        .GetInfo();
                }
            )
            .WithName("GetInfo")
            .WithOpenApi();

        return app;
    }
}
