$content = Get-Content "C:\Users\teige\OneDrive\Sync\Work\word\temp\text\004.txt" -encoding utf8
$result = foreach ($item in $content)
{
    $record = ([regex]::Matches($item,'<p.*?</p>') | Select-Object -Property Value)
 
    echo "<item>"
    echo "<word>"
    $record[0] -replace('<.*?>')
    echo "</word>"
    echo "<sentence>"
    $record[1] -replace('<.*?>')
    echo "</sentence>"
    echo "<chinese>"
    $record[2] -replace('<.*?>')
    echo "</chinese>"
    if ($record[3]) {echo '<rem>'($record[3] -replace('<.*?>'))'</rem>'}
    echo "</item>"
    if ($record[5]) {Add-Content $record[0] -path "C:\Users\teige\OneDrive\Sync\Work\word\temp\text\manual.txt" -encoding UTF8} 
}
$result | Out-File "C:\Users\teige\OneDrive\Sync\Work\word\temp\text\result4.txt"