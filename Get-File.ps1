param
(
  # Path to folder containing square .jpg thumbnails
  [Parameter(Mandatory=$true)]
  [ValidateScript({Test-Path $_})]
  [String]
  $Path
)

$ThumbnailFiles = Get-ChildItem -Path $Path -Filter '*.jpg'

foreach($File in $ThumbnailFiles) {

  $NewPath = Move-Item -Path $File.FullName -Destination 'C:\temp\SetADPhoto\processing\' -Force -PassThru

  #Call next runbook
  .\Set-ADPhoto.ps1 -JpgFilePath $NewPath.FullName
  
}