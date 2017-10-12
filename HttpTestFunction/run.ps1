# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$variation1Bookings = $requestBody.variation1Bookings
$variation1Visitors = $requestBody.variation1Visitors
$variation2Bookings = $requestBody.variation2Bookings
$variation2Visitors = $requestBody.variation2Visitors

if ($variation1Bookings -and $variation1Visitors -and $variation2Bookings -and $variation2Visitors) 
{
    cd D:\home\site\wwwroot\HttpTestFunction
    $result = d:\home\R-3.3.3\bin\x64\Rscript.exe script.r "Variation1" $variation1Bookings $variation1Visitors "Variation2" $variation2Bookings $variation2Visitors 2>&1    
    Out-File -Encoding Ascii -FilePath $res -inputObject $result
}
else
{    $text = $res.GetType().FullName;
    Out-File -Encoding Ascii -FilePath $res -inputObject "Insufficient Arguments - $text"
}


