Measure-Command {
$random = [System.Random]::new();
$errorTypes = @('Sandextractor overload', 'Conveyor misalignment', 'Valve stuck', 'Temperature warning');
$plcNames = @('PLC_A', 'PLC_B', 'PLC_C', 'PLC_D');
$statusCodes = @('OK', 'WARN', 'ERR');
$recordCount = 50000;
$logFilePath = "plc_log.txt";
$logEntries = [string[]]::new($recordCount);
$timestamp = [System.DateTime]::Now;
for ($i = 0; $i -lt $recordCount; $i++) {
$result = if ($random.Next(1, 9) -ne 4) { 'INFO';
$value = ' ';
$errorType = 'System running normally';}else{'ERROR';$errorTypeIndex=$random.Next(0,$errorTypes.Length);$errorType=$errorTypes[$errorTypeIndex];$value=if($errorType -eq 'Sandextractor overload'){$random.Next(1, 12);}else{' ';}
};
$timestampStr=$timestamp.AddSeconds(-$i).ToString("yyyy-MM-dd HH:mm:ss");
$plc=$plcNames[$random.Next(0,$plcNames.Length)];
$status=$statusCodes[$random.Next(0,$statusCodes.Length)];
$operator=$random.Next(101, 122);
$batch=$random.Next(1000, 1101);
$machineTemp=[math]::Round(($random.Next(60, 110)+$random.Next()),2);
$load=$random.Next(0,102);
$logEntries[$i]="$result;$timestampStr;$plc;$errorType;$value;$status;$operator;$batch;$machineTemp;$load";
};
[System.IO.File]::WriteAllLines($logFilePath, $logEntries, [System.Text.Encoding]::UTF8)
}