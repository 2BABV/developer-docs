var builder = DistributedApplication.CreateBuilder(args);

builder.AddDockerfile("docs", "../")
    .WithHttpEndpoint(targetPort: 8000)
    .WithExternalHttpEndpoints();

builder.Build().Run();
