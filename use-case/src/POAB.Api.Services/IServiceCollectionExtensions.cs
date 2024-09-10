using Microsoft.Extensions.DependencyInjection;
using POAB.Api.Services.Info;

namespace POAB.Api.Services;

public static class IServiceCollectionExtensions
{
    public static IServiceCollection AddRestServices(
        this IServiceCollection services
    )
    {
        services
            .AddScoped<InfoService>();

        return services;
    }
}
