$TempFolder = "C:\Temp\User Selections"
If (!(Test-Path $TempFolder)) {
    New-Item -Path $TempFolder -ItemType Directory
}

$Icon = "C:\Program Files\PPG\PPGBlue.ico"

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '590,320'
$Form.text                       = "PPG USCA Tint/Color Build"
$Form.TopMost                    = $true
$Form.Icon                       = $Icon

$PCTypeGroup                     = New-Object system.Windows.Forms.Groupbox
$PCTypeGroup.height              = 100
$PCTypeGroup.width               = 200
$PCTypeGroup.text                = "Type of PC"
$PCTypeGroup.location            = New-Object System.Drawing.Point(40,70)
$PCTypeGroup.Font                = 'Microsoft Sans Serif,10'

$PCTypeRadio1                    = New-Object system.Windows.Forms.RadioButton
$PCTypeRadio1.text               = "Tinter"
$PCTypeRadio1.AutoSize           = $true
$PCTypeRadio1.width              = 104
$PCTypeRadio1.height             = 20
$PCTypeRadio1.location           = New-Object System.Drawing.Point(22,27)
$PCTypeRadio1.Font               = 'Microsoft Sans Serif,10'

$PCTypeRadio2                    = New-Object system.Windows.Forms.RadioButton
$PCTypeRadio2.text               = "Color Matching"
$PCTypeRadio2.AutoSize           = $true
$PCTypeRadio2.width              = 104
$PCTypeRadio2.height             = 20
$PCTypeRadio2.location           = New-Object System.Drawing.Point(22,60)
$PCTypeRadio2.Font               = 'Microsoft Sans Serif,10'

$TinterGroup                     = New-Object system.Windows.Forms.Groupbox
$TinterGroup.height              = 210
$TinterGroup.width               = 160
$TinterGroup.text                = "Type of Tinter"
$TinterGroup.location            = New-Object System.Drawing.Point(325,25)
$TinterGroup.Font                = 'Microsoft Sans Serif,10'
$TinterGroup.enabled             = $false

$TinterRadio1                    = New-Object system.Windows.Forms.RadioButton
$TinterRadio1.text               = "Manual"
$TinterRadio1.AutoSize           = $true
$TinterRadio1.width              = 104
$TinterRadio1.height             = 20
$TinterRadio1.location           = New-Object System.Drawing.Point(20,30)
$TinterRadio1.Font               = 'Microsoft Sans Serif,10'

$TinterRadio2                   = New-Object system.Windows.Forms.RadioButton
$TinterRadio2.text               = "Dromont"
$TinterRadio2.AutoSize           = $true
$TinterRadio2.width              = 104
$TinterRadio2.height             = 20
$TinterRadio2.location           = New-Object System.Drawing.Point(20,65)
$TinterRadio2.Font               = 'Microsoft Sans Serif,10'

$TinterRadio3                    = New-Object system.Windows.Forms.RadioButton
$TinterRadio3.text               = "Fluid"
$TinterRadio3.AutoSize           = $true
$TinterRadio3.width              = 104
$TinterRadio3.height             = 20
$TinterRadio3.location           = New-Object System.Drawing.Point(20,100)
$TinterRadio3.Font               = 'Microsoft Sans Serif,10'

$TinterRadio4                    = New-Object system.Windows.Forms.RadioButton
$TinterRadio4.text               = "Corob"
$TinterRadio4.AutoSize           = $true
$TinterRadio4.width              = 104
$TinterRadio4.height             = 20
$TinterRadio4.location           = New-Object System.Drawing.Point(20,135)
$TinterRadio4.Font               = 'Microsoft Sans Serif,10'

$TinterRadio5                    = New-Object system.Windows.Forms.RadioButton
$TinterRadio5.text               = "Hero"
$TinterRadio5.AutoSize           = $true
$TinterRadio5.width              = 104
$TinterRadio5.height             = 20
$TinterRadio5.location           = New-Object System.Drawing.Point(20,170)
$TinterRadio5.Font               = 'Microsoft Sans Serif,10'

$SubmitBtn                       = New-Object system.Windows.Forms.Button
$SubmitBtn.text                  = "Submit"
$SubmitBtn.width                 = 60
$SubmitBtn.height                = 30
$SubmitBtn.location              = New-Object System.Drawing.Point(250,270)
$SubmitBtn.Font                  = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($PCTypeGroup,$TinterGroup,$SubmitBtn))
$PCTypeGroup.controls.AddRange(@($PCTypeRadio1,$PCTypeRadio2))
$TinterGroup.controls.AddRange(@($TinterRadio1,$TinterRadio2,$TinterRadio3,$TinterRadio4,$TinterRadio5))

$PCTypeRadio1.Add_Click({ GroupEnable })
$PCTypeRadio2.Add_Click({ GroupDisable })
$SubmitBtn.Add_Click({ SubmitClicked })

function GroupEnable {$TinterGroup.Enabled  = $true }
function GroupDisable {$TinterGroup.Enabled = $false }

#Check user selections 
function SubmitClicked {

    #Check to see if customizer process has been ran already
    $directoryInfo = (Get-ChildItem $TempFolder | Measure-Object).count
    if ($directoryInfo -ne 0){
    Get-ChildItem -Path $TempFolder -Include *.* -File -Recurse | foreach { $_.Delete()}
    }

        if ($PCTypeRadio2.Checked){
        New-Item -Path "C:\Temp\User Selections" -Name "Color.txt" -ItemType "file" -Value "Store is configured for color matching"}
        if ($TinterGroup.Enabled -eq $true){
           if ($TinterRadio1.Checked){
            New-Item -Path "C:\Temp\User Selections" -Name "Manual.txt" -ItemType "file" -Value "Store is configured a manual tinter"}
           if ($TinterRadio2.Checked){
            New-Item -Path "C:\Temp\User Selections" -Name "Dromont.txt" -ItemType "file" -Value "Store is configured a Dromont tinter"}
           if ($TinterRadio3.Checked){
            New-Item -Path "C:\Temp\User Selections" -Name "Fluid.txt" -ItemType "file" -Value "Store is configured a Fluid tinter"}
           if ($TinterRadio4.Checked){
            New-Item -Path "C:\Temp\User Selections" -Name "Corob.txt" -ItemType "file" -Value "Store is configured a Corob tinter"}
           if ($TinterRadio5.Checked){
            New-Item -Path "C:\Temp\User Selections" -Name "Hero.txt" -ItemType "file" -Value "Store is configured a Hero tinter"}     
        } 
     
     
    $form.Close()
    }




#Show form
[void]$Form.ShowDialog()

