# Helm Chart Validation Script for PowerShell
# This script validates Helm charts using helm lint, kubelint, and kubeconform

param(
    [Parameter(Mandatory=$true)]
    [string]$ChartPath,
    
    [switch]$Kubelint,
    [switch]$Kubeconform
)

# Colors for output
$Red = "Red"
$Green = "Green"
$Yellow = "Yellow"
$Cyan = "Cyan"

function Write-Status {
    param(
        [string]$Status,
        [string]$Message
    )
    
    switch ($Status) {
        "SUCCESS" { Write-Host "✓ $Message" -ForegroundColor $Green }
        "WARNING" { Write-Host "⚠ $Message" -ForegroundColor $Yellow }
        "ERROR" { Write-Host "✗ $Message" -ForegroundColor $Red }
        "INFO" { Write-Host "ℹ $Message" -ForegroundColor $Cyan }
    }
}

function Test-Command {
    param([string]$Command)
    $null = Get-Command $Command -ErrorAction SilentlyContinue
    return $?
}

function Test-HelmChart {
    param([string]$Path)
    
    $chartName = Split-Path $Path -Leaf
    Write-Status "INFO" "Validating Helm chart: $chartName"
    
    # Check if Chart.yaml exists
    $chartYaml = Join-Path $Path "Chart.yaml"
    if (-not (Test-Path $chartYaml)) {
        Write-Status "ERROR" "Chart.yaml not found in $Path"
        return $false
    }
    
    # Helm lint
    Write-Status "INFO" "Running helm lint on $chartName..."
    try {
        helm lint $Path
        if ($LASTEXITCODE -eq 0) {
            Write-Status "SUCCESS" "Helm lint passed for $chartName"
        } else {
            Write-Status "ERROR" "Helm lint failed for $chartName"
            return $false
        }
    } catch {
        Write-Status "ERROR" "Helm lint failed for $chartName`: $_"
        return $false
    }
    
    # Helm template (dry run)
    Write-Status "INFO" "Running helm template (dry run) on $chartName..."
    try {
        helm template $chartName $Path | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Status "SUCCESS" "Helm template dry run passed for $chartName"
        } else {
            Write-Status "ERROR" "Helm template dry run failed for $chartName"
            return $false
        }
    } catch {
        Write-Status "ERROR" "Helm template dry run failed for $chartName`: $_"
        return $false
    }
    
    return $true
}

function Test-WithKubelint {
    param([string]$Path)
    
    $chartName = Split-Path $Path -Leaf
    
    if (Test-Command "kubelint") {
        Write-Status "INFO" "Running kubelint on $chartName..."
        try {
            kubelint $Path
            if ($LASTEXITCODE -eq 0) {
                Write-Status "SUCCESS" "Kubelint passed for $chartName"
            } else {
                Write-Status "WARNING" "Kubelint found issues for $chartName"
            }
        } catch {
            Write-Status "WARNING" "Kubelint failed for $chartName`: $_"
        }
    } else {
        Write-Status "INFO" "kubelint not found, skipping kubelint validation (optional tool)"
    }
}

function Test-WithKubeconform {
    param([string]$Path)
    
    $chartName = Split-Path $Path -Leaf
    
    if (Test-Command "kubeconform") {
        Write-Status "INFO" "Running kubeconform on $chartName..."
        try {
            $manifests = helm template $chartName $Path
            $manifests | kubeconform -strict -summary -skip "ExternalSecret,SecretStore"
            if ($LASTEXITCODE -eq 0) {
                Write-Status "SUCCESS" "Kubeconform passed for $chartName"
            } else {
                Write-Status "WARNING" "Kubeconform found issues for $chartName"
            }
        } catch {
            Write-Status "WARNING" "Kubeconform failed for $chartName`: $_"
        }
    } else {
        Write-Status "WARNING" "kubeconform not found, skipping kubeconform validation"
    }
}

# Main execution
Write-Status "INFO" "Starting validation for chart: $ChartPath"
Write-Host "=========================================="

# Check if chart path exists
if (-not (Test-Path $ChartPath)) {
    Write-Status "ERROR" "Chart path does not exist: $ChartPath"
    exit 1
}

# Validate Helm chart
if (-not (Test-HelmChart $ChartPath)) {
    Write-Status "ERROR" "Helm chart validation failed"
    exit 1
}

# Additional validations if requested
if ($Kubelint) {
    Test-WithKubelint $ChartPath
}

if ($Kubeconform) {
    Test-WithKubeconform $ChartPath
}

Write-Status "SUCCESS" "Validation completed successfully"
Write-Host "=========================================="