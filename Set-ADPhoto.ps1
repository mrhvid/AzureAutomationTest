param
(
  # Path to .jpg thumbnails
  [Parameter(Mandatory=$true)]
  [ValidateScript({Test-Path $_})]
  [String]
  $JpgFilePath
)

    Write-Verbose -Message  "This is SetAdPhoto and the path is: $JpgFilePath"
    "This is SetAdPhoto and the path is: $JpgFilePath"

    $File = Get-ChildItem -Path $JpgFilePath
    $SamAccount = $File.BaseName
    $User = Get-ADUser -Identity $SamAccount

    if($User) {

        $ThumbPath = '{0}\{1}-96px{2}' -f $File.Directory, $File.BaseName, $File.Extension
        .\Resize-File.ps1 -JpgFilePath $JpgFilePath -Height 96 -Width 96 -OutputPath $ThumbPath

        [byte[]]$Picture = Get-Content $ThumbPath -Encoding byte
        $User | Set-ADUser -Replace @{thumbnailphoto=$Picture} -Credential (Get-AutomationPSCredential -Name "hyper1LabAdmin")

        'File {0} written to {1}' -f $File, $User.Name

    } else {

        # No user found
        Write-Debug "no user found in AD named $SamAccount"

    }