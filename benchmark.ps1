$users = 100
$url = "http://localhost:8000/api/articles"

Write-Host "Starting load test..."
Write-Host "Concurrent users:" $users
Write-Host "Target endpoint:" $url
Write-Host ""

$start = Get-Date

$jobs = 1..$users | ForEach-Object {
    Start-Job -ScriptBlock {
        param($url)

        $time = Measure-Command {
            Invoke-WebRequest $url -UseBasicParsing | Out-Null
        }

        return $time.TotalMilliseconds
    } -ArgumentList $url
}

$jobs | Wait-Job

$results = $jobs | Receive-Job
$jobs | Remove-Job

$end = Get-Date
$totalTime = ($end - $start).TotalSeconds

$stats = $results | Measure-Object -Average -Maximum -Minimum

Write-Host ""
Write-Host "Load test finished"
Write-Host "-------------------"
Write-Host "Users simulated:" $users
Write-Host "Total test time (s):" $totalTime
Write-Host "Min response time (ms):" $stats.Minimum
Write-Host "Avg response time (ms):" $stats.Average
Write-Host "Max response time (ms):" $stats.Maximum