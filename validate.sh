#!/bin/bash

# Helm Chart Validation Script
# This script validates Helm charts using helm lint, kubelint, and kubeconform

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/bamako-scripts/lib/common.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local status=$1
    local message=$2
    case $status in
        "SUCCESS")
            echo -e "${GREEN}✓${NC} $message"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}✗${NC} $message"
            ;;
        "INFO")
            echo -e "${YELLOW}ℹ${NC} $message"
            ;;
    esac
}

# Function to validate Helm chart
validate_helm_chart() {
    local chart_path=$1
    local chart_name=$(basename "$chart_path")
    
    print_status "INFO" "Validating Helm chart: $chart_name"
    
    # Check if Chart.yaml exists
    if [ ! -f "$chart_path/Chart.yaml" ]; then
        print_status "ERROR" "Chart.yaml not found in $chart_path"
        return 1
    fi
    
    # Helm lint
    print_status "INFO" "Running helm lint on $chart_name..."
    if helm lint "$chart_path"; then
        print_status "SUCCESS" "Helm lint passed for $chart_name"
    else
        print_status "ERROR" "Helm lint failed for $chart_name"
        return 1
    fi
    
    # Helm template (dry run)
    print_status "INFO" "Running helm template (dry run) on $chart_name..."
    if helm template "$chart_name" "$chart_path" > /dev/null; then
        print_status "SUCCESS" "Helm template dry run passed for $chart_name"
    else
        print_status "ERROR" "Helm template dry run failed for $chart_name"
        return 1
    fi
    
    return 0
}

# Function to validate with kubelint
validate_with_kubelint() {
    local chart_path=$1
    local chart_name=$(basename "$chart_path")
    
    if common::command_exists kubelint; then
        print_status "INFO" "Running kubelint on $chart_name..."
        if kubelint "$chart_path"; then
            print_status "SUCCESS" "Kubelint passed for $chart_name"
        else
            print_status "WARNING" "Kubelint found issues for $chart_name"
        fi
    else
        print_status "WARNING" "kubelint not found, skipping kubelint validation"
    fi
}

# Function to validate with kubeconform
validate_with_kubeconform() {
    local chart_path=$1
    local chart_name=$(basename "$chart_path")
    
    if common::command_exists kubeconform; then
        print_status "INFO" "Running kubeconform on $chart_name..."
        # Generate manifests and pipe to kubeconform
        if helm template "$chart_name" "$chart_path" | kubeconform -strict -summary -skip "ExternalSecret,SecretStore"; then
            print_status "SUCCESS" "Kubeconform passed for $chart_name"
        else
            print_status "WARNING" "Kubeconform found issues for $chart_name"
        fi
    else
        print_status "WARNING" "kubeconform not found, skipping kubeconform validation"
    fi
}

# Main function
main() {
    local chart_path=""
    local use_kubelint=false
    local use_kubeconform=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --kubelint)
                use_kubelint=true
                shift
                ;;
            --kubeconform)
                use_kubeconform=true
                shift
                ;;
            -*)
                print_status "ERROR" "Unknown option $1"
                echo "Usage: $0 <chart_path> [--kubelint] [--kubeconform]"
                exit 1
                ;;
            *)
                chart_path="$1"
                shift
                ;;
        esac
    done
    
    # Check if chart path is provided
    if [ -z "$chart_path" ]; then
        print_status "ERROR" "Chart path is required"
        echo "Usage: $0 <chart_path> [--kubelint] [--kubeconform]"
        exit 1
    fi
    
    # Check if chart path exists
    if [ ! -d "$chart_path" ]; then
        print_status "ERROR" "Chart path does not exist: $chart_path"
        exit 1
    fi
    
    print_status "INFO" "Starting validation for chart: $chart_path"
    echo "=========================================="
    
    # Validate Helm chart
    if ! validate_helm_chart "$chart_path"; then
        print_status "ERROR" "Helm chart validation failed"
        exit 1
    fi
    
    # Additional validations if requested
    if [ "$use_kubelint" = true ]; then
        validate_with_kubelint "$chart_path"
    fi
    
    if [ "$use_kubeconform" = true ]; then
        validate_with_kubeconform "$chart_path"
    fi
    
    print_status "SUCCESS" "Validation completed successfully"
    echo "=========================================="
}

# Run main function with all arguments
main "$@"
