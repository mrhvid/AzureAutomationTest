param
(
  # Path to .jpg thumbnails
  [Parameter(Mandatory=$true)]
  [ValidateScript({Test-Path $_})]
  [String]
  $JpgFilePathPath
)


    Write-Verbose -Message  "This is SetAdPhoto and the path is: $JpgFilePathPath"

    $File = Get-ChildItem -Path $JpgFilePathPath
    $SamAccount = $File.BaseName
    $User = Get-ADUser -Identity $SamAccount


    if($user) {

        [byte[]]$Picture = Get-Content $JpgFilePathPath -Encoding byte
        $User | Set-ADUser -Replace @{thumbnailphoto=$Picture} -Credential (Get-AutomationPSCredential -Name "hyper1LabAdmin")

        "File $File written to $($User.Name)"

    } else {

        # No user found
        Write-Debug "no user found in AD named $SamAccount"

    }
