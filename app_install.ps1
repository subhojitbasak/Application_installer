# List of applications to check and install/upgrade
$apps = @(
    "Python",
    "Java 8",
    "Oracle.JDK.17",
    "Oracle.JDK.21",
    "Python.Pip",
    "Notepad++.Notepad++",
    "JetBrains.IntelliJIDEA.Community",
    "Microsoft.VisualStudioCode",
    "Docker.DockerDesktop",
    "Oracle.VirtualBox",
    "Amazon.AWSCLI",
    "Git.Git",
    "Google.Chrome",
    "Kakao.PotPlayer",
    "Zoom.Zoom"
)

# Log file
$logFile = "C:\Users\Subhojit\subhojit\scripting\winget_install_log.txt"
if (Test-Path $logFile) { Remove-Item $logFile }

# Function to log messages
function Log {
    param ($message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logFile
}

# Function to add a directory to the system PATH
function Add-ToPath {
    param ($pathToAdd)
    $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
    if ($currentPath -notlike "*$pathToAdd*") {
        $newPath = "$currentPath;$pathToAdd"
        [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
        Log "Added $pathToAdd to PATH"
    } else {
        Log "$pathToAdd is already in PATH"
    }
}

foreach ($app in $apps) {
    # Check if the app is installed
    Write-Host "Checking $app..." -ForegroundColor Cyan
    Log "Checking $app..."
    $installed = winget list --id $app 2>&1
    if ($installed -match $app) {
        Write-Host "$app is already installed. Upgrading..." -ForegroundColor Green
        Log "$app is already installed. Upgrading..."
        if (winget upgrade --id $app --silent) {
            Write-Host "$app upgraded successfully!" -ForegroundColor Green
            Log "$app upgraded successfully!"
        } else {
            Write-Host "$app upgrade failed!" -ForegroundColor Red
            Log "$app upgrade failed!"
        }
    } else {
        Write-Host "$app is not installed. Installing..." -ForegroundColor Yellow
        Log "$app is not installed. Installing..."
        if (winget install --id $app --silent) {
            Write-Host "$app installed successfully!" -ForegroundColor Green
            Log "$app installed successfully!"
        } else {
            Write-Host "$app installation failed!" -ForegroundColor Red
            Log "$app installation failed!"
        }
    }
    
    # Add paths for specific applications
    switch ($app) {
        "Python.Python" {
            $pythonPath = "C:\Users\$env:USERNAME\AppData\Local\Microsoft\WindowsApps\python.exe"
            if (Test-Path $pythonPath) {
                Add-ToPath "C:\Users\$env:USERNAME\AppData\Local\Microsoft\WindowsApps"
            } else {
                Add-ToPath "C:\Program Files\Python"
            }
        }
        "Java 8" { Add-ToPath "C:\Program Files\Java\jdk1.8.0_281\bin" }
        "Oracle.JDK.17" { Add-ToPath "C:\Program Files\Java\jdk-17\bin" }
        "Oracle.JDK.21" { Add-ToPath "C:\Program Files\Java\jdk-21\bin" }
        "Git.Git" { Add-ToPath "C:\Program Files\Git\bin" }
        "Docker.DockerDesktop" { Add-ToPath "C:\Program Files\Docker\Docker" }
        "Amazon.AWSCLI" { Add-ToPath "C:\Program Files\Amazon\AWSCLI\bin" }
    }
}