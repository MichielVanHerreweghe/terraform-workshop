using Azure.Identity;

namespace POAB.Api.Extensions;

public static class IConfigurationManagerExtensions
{
    public static IConfigurationManager AddApplicationConfiguration(
        this IConfigurationManager configuration    
    )
    {
        Uri configurationStoreUrl = new(
            configuration
                .GetConnectionString(
                    "ConfigurationStore"
                )!
        );

        configuration
            .AddAzureAppConfiguration(options =>
                {
                    DefaultAzureCredential credential = new();

                    try
                    {
                        options
                            .Connect(
                                configurationStoreUrl, 
                                credential
                            );

                        options
                        .ConfigureKeyVault(keyVault =>
                            {
                                keyVault
                                    .SetCredential(
                                        credential
                                    );
                            }
                        );

                        Console
                            .WriteLine(
                                "Successfully connected to Azure App Configuration and Key Vault."
                            );
                    }
                    catch (
                        AuthenticationFailedException ex
                    )
                    {
                        Console
                            .WriteLine(
                                $"Authentication failed: {ex.Message}"
                            );

                        throw;
                    }
                }
            );

        return configuration;
    }
}
