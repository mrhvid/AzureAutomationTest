param
(
  # Path to square .jpg thumbnails
  [Parameter(Mandatory=$true)]
  [ValidateScript({Test-Path $_})]
  [String]
  $Path
)

whoami
"This is SetAdPhoto and the path is: $Path"

$File = Get-ChildItem -Path $Path
$SamAccount = $File.BaseName
$User = Get-ADUser -Identity $SamAccount


if($user) {

    [byte[]]$Picture = Get-Content $Path -Encoding byte
    $User | Set-ADUser -Replace @{thumbnailphoto=$Picture} -Credential (Get-AutomationPSCredential -Name "hyper1LabAdmin")

    "File $File written to $($User.Name)"

} else {

    # No user found
    Write-Debug "no user found in AD named $SamAccount"

}
 