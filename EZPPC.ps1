Add-Type -assembly System.Windows.Forms

$main_form = New-Object System.Windows.Forms.Form
$main_form.Width=400
$main_form.Height=250
$main_form.MinimizeBox = $False
$main_form.MaximizeBox= $False
$main_form.Text="EZ Power Plan Changer"
$main_form.StartPosition = "CenterScreen"
$main_form.SizeGripStyle = "Hide"
$txt_Cp=New-Object System.Windows.Forms.Label
$txt_Cp.Location= New-Object System.Drawing.Size(120,10)
$txt_Cp.Text="Current Plan:"
$txt_Cp.AutoSize=$true

$txt=New-Object System.Windows.Forms.Label
$txt.Location= New-Object System.Drawing.Size(190,10)
$txt.AutoSize=$true

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Width=375
$listBox.Height=100
$listBox.AutoSize=$False
$listBox.Location=New-Object System.Drawing.Size(05,40)

function getCurrentPlan
{
  [string]$lop=powercfg /getactivescheme
  $pp= $lop.split("(")
  $txt.Text=$pp[1].Replace(")","")
}

function ItemsofListBox {
$listBox.Items.Clear()
[string]$powerplans=powercfg /list
$powerplans=$powerplans.Replace("Existing Power Schemes (* Active) -----------------------------------",'').Trim()
$powerplans=$powerplans.Replace('*','')
$powerplans=$powerplans.Replace("Power Scheme GUID",'') 
$psp=$powerplans.Split(":").Trim()
foreach ($item in $psp)
{
  $listBox.Items.Add($item)
}  
}

function policyChanger {
  Set-ExecutionPolicy Undefined  -Scope CurrentUser
}

policyChanger
getCurrentPlan
ItemsofListBox

$btn=New-Object System.Windows.Forms.Button
$btn.Location= New-Object System.Drawing.Size(150,150)
$btn.Text="Change"

$add_ultimate=New-Object System.windows.Forms.Button

$add_ultimate.Location= New-Object System.Drawing.Size(305,150)
$add_ultimate.Text="+Ultimate"

function addUltimatePowerPlan{
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    ItemsofListBox
}
function changerAll {
 $selectedPlan=$listBox.SelectedItem
  $selectedPlan= $selectedPlan.split('(')
$selectedPlan[0].Trim()
powercfg /s $selectedPlan[0].Trim()
getCurrentPlan
}

$btn.add_Click{
  changerAll 
}
$add_ultimate.add_Click{
addUltimatePowerPlan
}
$main_form.Controls.Add($listBox)
$main_form.Controls.Add($btn)
$main_form.Controls.Add($txt_Cp)
$main_form.Controls.Add($txt)
$main_form.Controls.Add($add_ultimate)
$main_form.ShowDialog()
