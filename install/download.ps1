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

    $loginResponse = Invoke-WebRequest "https://dev.sitecore.net/api/authorization" -Method Post -Body @{username = $SitecoreUsername,
                                                                                                         password = $SitecorePassword,
                                                                                                         rememberMe = $true
                        } -SessionVariable "sitecoreDownloadSession" -UseBasicParsing

                        if ($null -eq $loginResponse -or $loginResponse.StatusCode -ne 200 -or $loginResponse.Content -eq "false")
                        {
                            throw ("Unable to login to '{0}' with the supplied credentials." -f $sitecoreDownloadUrl)
                        }

                        Write-Verbose ("Logged in to '{0}'." -f $sitecoreDownloadUrl)
                    

                    # Download package using saved session
                    Invoke-WebRequest -Uri $fileUrl -OutFile $filePath -WebSession $sitecoreDownloadSession -UseBasicParsing
