# DatabaseSample

1. Download dotnet 8 from https://dotnet.microsoft.com/en-us/download
1. You may need to install MAUI libraries (if VS was not installed first) from https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-workload-install
1. To build the application

dotnet build

1. To run the application

dotnet build -t:Run -f:<youroperatingsystem>

for example

dotnet build -t:Run -f net8.0-maccatalyst 