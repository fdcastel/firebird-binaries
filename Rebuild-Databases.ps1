[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline=$true)]
    [System.String]
    $DbPath=$Null,

    [System.String]
    $DbPrefix='test',
    
    [ValidateSet('All', 'fb25', 'fb30', 'fb40', 'fb50')] 
    [System.String[]]
    $Engines = 'All'
)

$dbFolder = Join-Path $env:TEMP 'firebird-databases'
if ($DbPath) {
    $dbFolder = $DbPath
}

mkdir -Force $dbFolder | Out-Null

# Build databases
if ($Engines -eq 'All') {
    $Engines = 'fb25', 'fb30', 'fb40', 'fb50'
}
$Engines | ForEach-Object {
    $engine = $_

    $engineFolder = Join-Path $PSScriptRoot $engine
    $isql = Join-Path $engineFolder 'isql.exe'

    $database = Join-Path $dbFolder "$DbPrefix.$engine.fdb"
    Remove-Item $database -Force -ErrorAction SilentlyContinue

    Write-Verbose "Creating '$engine' database in '$database'..."
    @"
    CREATE DATABASE '$database'
        USER 'SYSDBA' PASSWORD 'masterkey'
        PAGE_SIZE 8192 DEFAULT CHARACTER SET UTF8;
"@ | & $isql -quiet | Out-Null
}
