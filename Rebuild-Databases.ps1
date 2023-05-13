[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline=$true)]
    [System.String]
    $DbPath=$Null,

    [System.String]
    $DbPrefix='test',
    
    [ValidateSet('All', 'fb25', 'fb30', 'fb40', 'fb50')] 
    [System.String[]]
    $Engines = 'All',
    
    [ValidateSet(4096, 8192, 16384, 32768)] 
    [System.Int32]
    $PageSize = 8192,

    [System.String]
    $Charset = 'UTF8'
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

    Write-Verbose "Creating '$database' (PageSize=$PageSize, Charset='$Charset')..."
    @"
    CREATE DATABASE '$database'
        USER 'SYSDBA' PASSWORD 'masterkey'
        PAGE_SIZE $PageSize DEFAULT CHARACTER SET $Charset;
"@ | & $isql -quiet | Out-Null
}
