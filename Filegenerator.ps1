$timestamp=[System.DateTime]::Now
$random=[System.Random]::new()
$errorTypes=@('Sandextractor overload','Conveyor misalignment','Valve stuck','Temperature warning')
$plcNames=@('PLC_A','PLC_B','PLC_C','PLC_D')
$statusCodes=@('OK','WARN','ERR')
$recordCount=50000
$logEntries=[string[]]::new($recordCount)
while($recordCount -gt 0){
    $recordCount--
    if($random.Next(1, 8) -eq 4){
                $errorTypeIndex=$random.Next(0,4)
                $value = ' '
            if($errorTypeIndex -eq 0){
                $value = $random.Next(1, 12)
            }
            $logEntries[$recordCount]="ERROR;$($timestamp.AddSeconds(-$recordCount).ToString("yyyy-MM-dd HH:mm:ss"));$($plcNames[$random.Next(0,4)]);$($errorTypes[$errorTypeIndex]);$value;$($statusCodes[$random.Next(0,3)]);$($random.Next(101, 121));$($random.Next(1000, 1100));$([math]::round($random.NextDouble()*(110-60)+60,2));$($random.Next(0,101))"
        }
    else{
        $logEntries[$recordCount]="INFO;$($timestamp.AddSeconds(-$recordCount).ToString("yyyy-MM-dd HH:mm:ss"));$($plcNames[$random.Next(0,4)]);System running normally;' ';$($statusCodes[$random.Next(0,3)]);$($random.Next(101, 121));$($random.Next(1000, 1100));$([math]::round($random.NextDouble()*(110-60)+60,2));$($random.Next(0,101))"
    }
}
[System.IO.File]::WriteAllLines("plc_log.txt", $logEntries)
[System.DateTime]::Now - $timestamp