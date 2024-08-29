# BLINDDATE

![BLINDDATE (1)](https://github.com/user-attachments/assets/af98baa1-20b9-458e-ae98-5622e31f3343)

BLINDDATE is a Haskell script I designed to perform a variety of operations on NetCDF files using the ncap2, ncks, and ncrename utilities from the NCO (NetCDF Operators) suite. This script supports multiple arithmetic operations, variable extractions.

## Features

- Arithmetic Operations: Apply multiple arithmetic operations to variables in NetCDF files using ncap2.
- Variable Extraction: Extract specific variables from NetCDF files using ncks.
- Variable Renaming: Rename variables within NetCDF files using ncrename.

## Requirements

- GHC (Glasgow Haskell Compiler)
- NCO (NetCDF Operators)
- Ensure you have these installed before using the script

## Usage

Compile the script:

```bash
ghc -o BLINDDATE BLINDDATE.hs
```

Run the script with basic operations:

```bash
./BLINDDATE <input.nc> <output.nc> <operations...>
```

Example:

```bash
./BLINDDATE input.nc output.nc 'var1=var1*2' 'var2=var1+var2'
```

## Extracting Variables

You can extract a variable using the extractVariable function (note: this function must be used within the script or extended in your workflow):

```haskell
extractVariable "input.nc" "output.nc" "variableName"
```

###Renaming Variables

You can rename a variable using the renameVariable function (note: this function must be used within the script or extended in your workflow):

```haskell
renameVariable "file.nc" "oldVarName" "newVarName"
```
Example, (e.g. applying multiple operations):

```bash
./BLINDDATE input.nc output.nc 'var1=var1+100' 'var2=var2*0.5'
```
