using POAB.Api.Services;

namespace POAB.Api.Extensions;

public static class WebApplicationBuilderExtensions
{
    public static IServiceCollection AddApplicationServices(
        this IServiceCollection services    
    )
    {
        services
            .AddSwaggerServices()
            .AddRestServices();

        return services;
    }

    private static IServiceCollection AddSwaggerServices(
        this IServiceCollection services    
    )
    {
        services
            .AddEndpointsApiExplorer()
            .AddSwaggerGen();

        return services;
    }

    private static IServiceCollection AddApplicationInsightsServices(
        this IServiceCollection services
    )
    {
        services
            .AddApplicationInsightsTelemetry();

        return services;
    }
}
