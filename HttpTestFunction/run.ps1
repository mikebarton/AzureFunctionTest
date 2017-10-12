# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$v1Bookings = $requestBody.v1Bookings
$v1Visitors = $requestBody.v1Visitors
$v2Bookings = $requestBody.v2Bookings
$v2Visitors = $requestBody.v2Visitors

if ($v1Bookings -and $v1Visitors -and $v2Bookings -and $v2Visitors) 
{
    cd D:\home\site\wwwroot\HttpTestFunction
    $result = d:\home\R-3.3.3\bin\x64\Rscript.exe script.r $v1Bookings $v1Visitors $v2Bookings $v2Visitors 2>&1    
    Out-File -Encoding Ascii -FilePath $res -inputObject "Hello $result"
}
else
{
    Out-File -Encoding Ascii -FilePath $res -inputObject "Insufficient Arguments"
}


