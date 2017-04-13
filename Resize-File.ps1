param
(
  # Path to square .jpg thumbnails
  [Parameter(Mandatory=$true)]
  [ValidateScript({Test-Path $_})]
  [String]
  $Path
)

# -------------------  resize picture 

Add-Type -AssemblyName System.Drawing
$Path =           ''
$JpgFile =       ''
$ThumbFile =  '-96px.jpg'
$Height =         96
$Width =          96


$OldImage = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $JpgFile
$Bitmap =   New-Object -TypeName System.Drawing.Bitmap -ArgumentList $Width, $Height
$NewImage = [System.Drawing.Graphics]::FromImage($Bitmap)

#Retrieving the best quality possible
$NewImage.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$NewImage.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$NewImage.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

$NewImage.DrawImage($OldImage, $(New-Object -TypeName System.Drawing.Rectangle -ArgumentList 0, 0, $Width, $Height))

#Write-Log "96x96 px image saved to $OutputPath"
#$Bitmap.Save($ThumbFile)

$OldImage.Dispose()
$Bitmap.Dispose()
$NewImage.Dispose() 