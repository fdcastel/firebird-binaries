# firebird-binaries

Minimal set of files to use Firebird Embedded. Ideal for build test environments. 



## How to install

Simply `git checkout` this repository. All necessary files are included.



## Usage 

Just configure your application to use `fbclient.dll` of the desired Firebird version. The configuration file `firebird.conf` is already configured to use the embedded server.



## Rebuild-Databases

You can use `Rebuild-Databases.ps1` script to build empty databases for each Firebird version.

```powershell
Rebuild-Databases.ps1 [[-DbPath] <string>] [[-DbPrefix] <string>] [<CommonParameters>]
```

You may inform the target folder with `-DbPath`. If not informed `$env:TEMP\firebird-databases` will be used.

You may inform a database prefix with `-DbPrefix`. If not informed `test` will be used.



### Example

```powershell
.\Rebuild-Databases.ps1 -DbPath 'C:\Temp' -DbPrefix 'Foo' -Verbose
VERBOSE: Creating 'fb25' database in 'C:\Temp\Foo.fb25.fdb'...
VERBOSE: Creating 'fb30' database in 'C:\Temp\Foo.fb30.fdb'...
VERBOSE: Creating 'fb40' database in 'C:\Temp\Foo.fb40.fdb'...
VERBOSE: Creating 'fb50' database in 'C:\Temp\Foo.fb50.fdb'...
```
