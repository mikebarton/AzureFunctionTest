# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$name = $requestBody.name

# GET method: each querystring parameter is its own variable
if ($req_query_name) 
{
    $name = $req_query_name 
}
cd D:\home\site\wwwroot\HttpTestFunction
$result = d:\home\R-3.3.3\bin\x64\Rscript.exe script.r 6251 78502 7819 97070 0.975 0.05 2>&1

Out-File -Encoding Ascii -FilePath $res -inputObject "Hello $result"
