function ConvertStringToBGVRaw () {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)][string]$Array
    )
    
    # Converts string to BGValueRaw object

    Write-Verbose "Processing string with length $($Array.Length)"

    $Entries = $Array -split "`n"
    Write-Verbose "Converting total of $($Entries.Count) entries"

    foreach ($Entry in $Entries) {
        Write-Verbose "Converting entry $Entry"
        $Values = $Entry.Split("`t")
        if ($Values.Count -ne 5) {
            Write-Error "Entry $Entry has $($Values.Count) values, expected 5"
        }

        # return value
        $retValue = [BGValueRaw]::new(
            $Values[0],$Values[1],$Values[2],$Values[3],$Values[4]
        ) 
        # convert to mmol/L
        $retValue.BGValue = ConvertToMMolPerL -mgdl $retValue.BGValue
        # return object
        return $retValue
    }
}