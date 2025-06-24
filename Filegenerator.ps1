Measure-Command{
$random = [System.Random]::new()

$errorTypes = @('Sandextrator overload', 'Conveyor misalignment', 'Valve stuck', 'Temperature warning')
$plcNames = @('PLC_A', 'PLC_B', 'PLC_C', 'PLC_D')
$statusCodes = @('OK', 'WARN', 'ERR')
$recordCount = 50000
$logFilePath = "plc_log.txt"

$results = New-Object string[] $recordCount
$timestamps = New-Object string[] $recordCount
$plcs = New-Object string[] $recordCount
$statusList = New-Object string[] $recordCount
$operators = New-Object int[] $recordCount
$batches = New-Object int[] $recordCount
$machineTemps = New-Object int[] $recordCount
$loads = New-Object int[] $recordCount
$values = New-Object string[] $recordCount
$errorTypeStrings = New-Object string[] $recordCount

$timestamp = [System.DateTime]::Now

for ($i = 0; $i -lt $recordCount; $i++) {
    $results[$i] = if ($random.Next(1, 9) -ne 4) { 'INFO' } else { 'ERROR' }
    $timestamps[$i] = $timestamp.AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss")
    $plcs[$i] = $plcNames[$random.Next(0, $plcNames.Length)]
    $statusList[$i] = $statusCodes[$random.Next(0, $statusCodes.Length)]
    $operators[$i] = $random.Next(101, 122)
    $batches[$i] = $random.Next(1000, 1101)
    $machineTemps[$i] = [math]::Round(($random.Next(60, 110) + $random.Next()), 2)
    $loads[$i] = $random.Next(0, 102)
    
    if ($results[$i] -eq 'ERROR') {
        $errorTypeIndex = $random.Next(0, $errorTypes.Length)
        $errorTypeStrings[$i] = $errorTypes[$errorTypeIndex]
        $values[$i] = if ($errorTypeStrings[$i] -eq 'Sandextrator overload') { $random.Next(1, 12) } else { ' ' }
    } else {
        $values[$i] = ' '
        $errorTypeStrings[$i] = 'System running normally'
    }
}

$logEntries = 0..($recordCount - 1) | ForEach-Object {
    "$($results[$_]);$($timestamps[$_]);$($plcs[$_]);$($errorTypeStrings[$_]);$($values[$_]);$($operators[$_]);$($batches[$_]);$($machineTemps[$_]);$($loads[$_])"
}

$streamWriter = [System.IO.StreamWriter]::new($logFilePath, $false, [System.Text.Encoding]::UTF8)

foreach ($entry in $logEntries) {
    $streamWriter.WriteLine($entry)
}

$streamWriter.Close()
}