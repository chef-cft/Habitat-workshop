using Microsoft.Extensions.Configuration;  
using Microsoft.Extensions.Hosting;  
using Microsoft.Extensions.Logging;  
using System.Threading;  
using System.Threading.Tasks;  
  
public class ApplicationLifetimeHostedService : IHostedService
{
    private readonly ILogger _logger;
    private readonly IHostApplicationLifetime _appLifetime;

    public ApplicationLifetimeHostedService(
        ILogger<ApplicationLifetimeHostedService> logger, 
        IHostApplicationLifetime appLifetime)
    {
        _logger = logger;
        _appLifetime = appLifetime;
    }

    public Task StartAsync(CancellationToken cancellationToken)
    {
        _appLifetime.ApplicationStarted.Register(OnStarted);
        _appLifetime.ApplicationStopping.Register(OnStopping);
        _appLifetime.ApplicationStopped.Register(OnStopped);

        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }

    private void OnStarted()
    {
        _logger.LogInformation("OnStarted has been called.");

        // Perform post-startup activities here
    }

    private void OnStopping()
    {
        _logger.LogInformation("OnStopping has been called.");

        while(System.IO.File.Exists("myfile")) {
            _logger.LogInformation("Waiting for transactions to complete...");
            System.Threading.Thread.Sleep(1000);
        }
    }

    private void OnStopped()
    {
        _logger.LogInformation("OnStopped has been called.");

        // Perform post-stopped activities here
    }
}