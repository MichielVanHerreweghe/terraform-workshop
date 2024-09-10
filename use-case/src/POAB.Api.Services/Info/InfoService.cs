using Dapper;
using Microsoft.Extensions.Configuration;
using Npgsql;

namespace POAB.Api.Services.Info;

public class InfoService
{
    private readonly IConfiguration _configuration;

    public InfoService(
        IConfiguration configuration    
    )
    {
        _configuration = configuration;
    }

    public async Task<Info> GetInfo()
    {
        try
        {
            NpgsqlConnection connection = new(
                _configuration
                    .GetConnectionString("Database")
            );

            await connection.OpenAsync();

            string query = @"
                SELECT 1+1;
            ";

            var result = await connection
                .QueryAsync(query);
        }
        catch (Exception ex)
        {
            return new Info(
                false,
                _configuration
                    .GetConnectionString("Database")!,
                _configuration["ApplicationInsights:ConnectionString"]!
            );
        }

        return new Info(
            true,
            null,
            _configuration["ApplicationInsights:ConnectionString"]!
        );
    }
}

public record Info(
    bool DatabaseOk,
    string? DatabaseConnectionString,
    string ApplicationInsightsConnectionString
);