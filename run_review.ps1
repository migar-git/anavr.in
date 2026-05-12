param([string]$Mode="all")
$exitCode=0
$htmls = Get-ChildItem -Recurse -Filter *.html | Where-Object { $_.FullName -notmatch '\\.git\' }
Write-Host "[discover] HTML pages: $($htmls.Count)"
foreach ($f in $htmls) {
    [regex]::Matches((Get-Content $f.FullName -Raw), '(?:href="|location\.href='')(blog|products)/[a-z0-9_-]+\.html') | ForEach-Object {
        $t = $_.Value -replace '.*?(blog|products)/', '$1/' -replace "['""]\s*$",""
        if (-not (Test-Path $t)) { Write-Host "  MISSING $($f.Name) -> $t"; $exitCode=1 }
    }
}
if (Test-Path sitemap.xml) { Write-Host "[verify] sitemap urls: $((Select-String -Path sitemap.xml -Pattern '<url>').Count)" }
exit $exitCode
