param
(
  # Path to .jpg thumbnails
  [Parameter(Mandatory=$true)]
  [ValidateScript({Test-Path $_})]
  [String]
  $JpgFilePathPath,

  # Pixel height of output
  [Parameter(Mandatory=$true)]
  [ValidateRange(96,1024)]
  [Int]
  $Height,

  # Pixel height of output
  [Parameter(Mandatory=$true)]
  [ValidateRange(96,1024)]
  [Int]
  $Width,

  # Full path including filename output
  [Parameter(Mandatory=$true)]
  [string]
  $OutputPath
)

  Add-Type -AssemblyName System.Drawing

  $OldImage = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $JpgFilePath
  $Bitmap =   New-Object -TypeName System.Drawing.Bitmap -ArgumentList $Width, $Height
  $NewImage = [System.Drawing.Graphics]::FromImage($Bitmap)

  #Retrieving the best quality possible
  $NewImage.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $NewImage.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $NewImage.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

  $NewImage.DrawImage($OldImage, $(New-Object -TypeName System.Drawing.Rectangle -ArgumentList 0, 0, $Width, $Height))

  #Write-Log "96x96 px image saved to $OutputPath"
  $Bitmap.Save($OutputPath)

  $OldImage.Dispose()
  $Bitmap.Dispose()
  $NewImage.Dispose() 