Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Caminho do log
$logPath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition) -ChildPath "log.txt"

# Zera o log ao iniciar o script
"" | Out-File -FilePath $logPath -Encoding utf8

# Função para registrar log
function Escrever-Log {
    param ([string]$mensagem)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $mensagem" | Out-File -FilePath $logPath -Append -Encoding utf8
}

# Lista de passos
$steps = @(
    "Passo 1: Preparando ambiente...",
    "Passo 2: Verificando arquivos...",
    "Passo 3: Conectando com o servidor...",
    "Passo 4: Executando tarefa principal...",
    "Passo 5: Finalizando ajustes...",
    "Passo 6: Limpando e finalizando..."
)

# Criar formulário principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Hcode - Execução de Passos"
$form.Size = New-Object System.Drawing.Size(600, 450)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::White

# Cabeçalho com logo textual
$headerLabel = New-Object System.Windows.Forms.Label
$headerLabel.Location = New-Object System.Drawing.Point(20, 10)
$headerLabel.Size = New-Object System.Drawing.Size(560, 40)
$headerLabel.Text = "Hcode - Execução de Passos"
$headerLabel.Font = New-Object System.Drawing.Font("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
$headerLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 118, 12)  # Laranja
$headerLabel.TextAlign = "MiddleCenter"
$form.Controls.Add($headerLabel)

# Label de instrução/status
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(20, 60)
$statusLabel.Size = New-Object System.Drawing.Size(560, 30)
$statusLabel.Text = "Selecione pelo menos 1 passo e clique em Iniciar"
$statusLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$statusLabel.TextAlign = "MiddleCenter"
$form.Controls.Add($statusLabel)

# Checklist
$checklist = New-Object System.Windows.Forms.CheckedListBox
$checklist.Location = New-Object System.Drawing.Point(50, 100)
$checklist.Size = New-Object System.Drawing.Size(500, 200)
$checklist.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$checklist.BorderStyle = 'FixedSingle'
$checklist.CheckOnClick = $true
$form.Controls.Add($checklist)

# Botão Iniciar
$btnIniciar = New-Object System.Windows.Forms.Button
$btnIniciar.Location = New-Object System.Drawing.Point(130, 320)
$btnIniciar.Size = New-Object System.Drawing.Size(150, 40)
$btnIniciar.Text = "Iniciar"
$btnIniciar.Enabled = $false
$btnIniciar.FlatStyle = 'Flat'
$btnIniciar.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnIniciar.BackColor = [System.Drawing.Color]::FromArgb(255, 118, 12)
$btnIniciar.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnIniciar)

# Botão Reset
$btnReset = New-Object System.Windows.Forms.Button
$btnReset.Location = New-Object System.Drawing.Point(320, 320)
$btnReset.Size = New-Object System.Drawing.Size(150, 40)
$btnReset.Text = "Resetar"
$btnReset.FlatStyle = 'Flat'
$btnReset.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$btnReset.BackColor = [System.Drawing.Color]::FromArgb(121, 117, 108)
$btnReset.ForeColor = [System.Drawing.Color]::White
$form.Controls.Add($btnReset)

# Função de reset da checklist
function Resetar-Passos {
    $checklist.Items.Clear()
    foreach ($s in $steps) {
        $checklist.Items.Add("☐ $s")
    }
    $btnIniciar.Enabled = $false
    $statusLabel.Text = "Selecione pelo menos 1 passo e clique em Iniciar"
    Escrever-Log "Interface resetada"
}

# Verifica se há ao menos um passo marcado
function Verificar-Marcados {
    $marcados = 0
    for ($i = 0; $i -lt $checklist.Items.Count; $i++) {
        if ($checklist.GetItemChecked($i) -and $checklist.Items[$i] -notmatch '^✔️') {
            $marcados++
        }
    }
    $btnIniciar.Enabled = ($marcados -ge 1)
}

# Evento para checar itens
$checklist.add_ItemCheck({ Start-Sleep -Milliseconds 100; Verificar-Marcados })

# Evento botão Iniciar
$btnIniciar.Add_Click({
        for ($i = 0; $i -lt $checklist.Items.Count; $i++) {
            if ($checklist.GetItemChecked($i) -and $checklist.Items[$i] -notmatch '^✔️') {
                $texto = $steps[$i]
                $statusLabel.Text = $texto
                $form.Refresh()
                Escrever-Log "Executando: $texto"
                Start-Sleep -Seconds 2
                $checklist.Items[$i] = "✔️ $texto"
            }
        }
        $statusLabel.Text = "Execução concluída. Utilize 'Resetar' para limpar ou marque novos passos."
        Escrever-Log "Execução concluída"
        $btnIniciar.Enabled = $false
    })

# Evento botão Reset
$btnReset.Add_Click({ Resetar-Passos })

# Inicialização
Resetar-Passos

[void]$form.ShowDialog()
