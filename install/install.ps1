#Original: https://github.com/Sitecore/docker-images/blob/master/modules/SitecoreImageBuilder/SitecoreImageBuilder.psm1
function Invoke-PackageRestore
{
    [CmdletBinding(SupportsShouldProcess = $true)]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword", "SitecorePassword")]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SitecoreUsername
        ,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$SitecorePassword
    )

    if (Test-Path "Sitecore.Commerce.WDP.2019.07-4.0.165.zip")
    {
      Extract();
    } else {

    $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{username = $SitecoreUsername,
                                                                                                         password = $SitecorePassword,
                                                                                                         rememberMe = $true
                        } -SessionVariable "sitecoreDownloadSession" -UseBasicParsing

    if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
    {
        throw ("Unable to login to '{0}' with the supplied credentials." -f $sitecoreDownloadUrl)
    }

    if ()

    Write-Verbose ("Logged in to '{0}'." -f $sitecoreDownloadUrl)

    Write-Host "Downloading Sitecore.Commerce.WDP.2019.07-4.0.165.zip, this may take some time."

    # Download package using saved session
    Invoke-WebRequest -Uri "https://dev.sitecore.net/~/media/07F9ABE455944146B37E9D71CA781A27.ashx" -OutFile "Sitecore.Commerce.WDP.2019.07-4.0.165.zip" -WebSession $sitecoreDownloadSession -UseBasicParsing

    Extract();
    }
}

function Extract()
{
    Expand-Archive -Path "Sitecore.Commerce.WDP.2019.07-4.0.165.zip"

    Expand-Archive -Path "Sitecore.BizFX.SDK.3.0.7.zip" -DestinationPath "..\"

    Move-Item -Path "speak-ng-bcl-0.8.0.tgz" -DestinationPath "..\"

    Move-Item -Path "speak-styling-0.9.0-r00078" -DestinationPath "..\"
}
