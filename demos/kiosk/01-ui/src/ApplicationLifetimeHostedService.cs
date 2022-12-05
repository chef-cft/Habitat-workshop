using Microsoft.Extensions.Configuration;  
using Microsoft.Extensions.Hosting;  
using Microsoft.Extensions.Logging;  
using System.Threading;  
using System.Threading.Tasks;  
using System;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;

namespace kiosk_ui
{
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

            HttpClient client = new HttpClient();
            client.BaseAddress = new Uri("http://localhost:8002/");
            client.DefaultRequestHeaders.Accept.Clear();

            bool exit = false;

            _logger.LogInformation("Checking for active transactions");
            while(!exit){
                var response = client.GetAsync("exists").GetAwaiter().GetResult();
                if (response.IsSuccessStatusCode) {
                    _logger.LogInformation("Waiting for transactions to complete...");
                }else{
                    _logger.LogInformation("No transactions running. Shutting down.");
                    exit = true;
                }
                System.Threading.Thread.Sleep(1000);
            }

            //while(System.IO.File.Exists("myfile")) {
            //    System.Threading.Thread.Sleep(1000);
            //}
        }

        private void OnStopped()
        {
            _logger.LogInformation("OnStopped has been called.");

            // Perform post-stopped activities here
        }
    }
}