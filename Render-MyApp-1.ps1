# Render-MyApp.ps1
# A simple PowerShell script that displays a nice GUI window

# Load the Windows Forms assembly
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create a new form
$form = New-Object System.Windows.Forms.Form
$form.Text = "My Amazing Application"
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(240, 240, 250)
$form.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false

# Create a welcome label
$welcomeLabel = New-Object System.Windows.Forms.Label
$welcomeLabel.Text = "Welcome to My Amazing Application!"
$welcomeLabel.AutoSize = $false
$welcomeLabel.Size = New-Object System.Drawing.Size(360, 60)
$welcomeLabel.Location = New-Object System.Drawing.Point(20, 30)
$welcomeLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
$welcomeLabel.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$welcomeLabel.ForeColor = [System.Drawing.Color]::FromArgb(50, 50, 150)

# Create a description label
$descriptionLabel = New-Object System.Windows.Forms.Label
$descriptionLabel.Text = "This is a simple PowerShell GUI application built with Windows Forms."
$descriptionLabel.AutoSize = $false
$descriptionLabel.Size = New-Object System.Drawing.Size(360, 40)
$descriptionLabel.Location = New-Object System.Drawing.Point(20, 100)
$descriptionLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter

# Create a close button
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Text = "Close Application"
$closeButton.Size = New-Object System.Drawing.Size(150, 40)
$closeButton.Location = New-Object System.Drawing.Point(125, 180)
$closeButton.BackColor = [System.Drawing.Color]::FromArgb(230, 230, 250)
$closeButton.ForeColor = [System.Drawing.Color]::FromArgb(50, 50, 150)
$closeButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$closeButton.Cursor = [System.Windows.Forms.Cursors]::Hand

# Add the button click event handler
$closeButton.Add_Click({
        $form.Close()
    })

# Add controls to the form
$form.Controls.Add($welcomeLabel)
$form.Controls.Add($descriptionLabel)
$form.Controls.Add($closeButton)

# Show the form
$form.ShowDialog()

