Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Meu Formulário"
$form.Width = 400
$form.Height = 300

$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(10, 10)
$textbox.Size = New-Object System.Drawing.Size(200, 20)
$textbox.Text = "Digite seu nome"
$form.Controls.Add($textbox)

$datepicker = New-Object System.Windows.Forms.DateTimePicker
$datepicker.Location = New-Object System.Drawing.Point(10, 40)
$datepicker.Size = New-Object System.Drawing.Size(200, 20)
$datepicker.Format = [System.Windows.Forms.DateTimePickerFormat]::Short
$form.Controls.Add($datepicker)

$combobox = New-Object System.Windows.Forms.ComboBox
$combobox.Location = New-Object System.Drawing.Point(10, 70)
$combobox.Size = New-Object System.Drawing.Size(200, 20)
$combobox.Items.Add("Opção 1")
$combobox.Items.Add("Opção 2")
$combobox.Items.Add("Opção 3")
$form.Controls.Add($combobox)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10, 100)
$button.Size = New-Object System.Drawing.Size(100, 20)
$button.Text = "Enviar"
$button.Add_Click({
        $data = @{
            "name"   = $textbox.Text
            "option" = $combobox.SelectedItem
            "date"   = $datepicker.Value.ToString("dd-MM-yyyy")
        }
        $data | ConvertTo-Json | Out-File "form.json"
        Write-Host "Formulário enviado!"
    })
$form.Controls.Add($button)

$form.ShowDialog()
