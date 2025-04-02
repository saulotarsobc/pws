Add-Type -AssemblyName System.Windows.Forms

# Caminho do log
$logPath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Definition) -ChildPath "log.txt"

# Função para registrar no log
function Write-Log {
    param (
        [string]$mensagem
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $mensagem" | Out-File -FilePath $logPath -Append -Encoding utf8
}

# Criar janela principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Execução Passo a Passo"
$form.Size = New-Object System.Drawing.Size(400, 200)
$form.StartPosition = "CenterScreen"

# Label para status
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(30, 30)
$statusLabel.Text = "Clique em 'Iniciar' para começar"
$form.Controls.Add($statusLabel)

# Barra de progresso
$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Location = New-Object System.Drawing.Point(30, 70)
$progressBar.Size = New-Object System.Drawing.Size(320, 20)
$progressBar.Minimum = 0
$progressBar.Maximum = 6
$progressBar.Value = 0
$form.Controls.Add($progressBar)

# Botão iniciar
$startButton = New-Object System.Windows.Forms.Button
$startButton.Location = New-Object System.Drawing.Point(140, 110)
$startButton.Size = New-Object System.Drawing.Size(100, 30)
$startButton.Text = "Iniciar"
$form.Controls.Add($startButton)

# Lógica dos passos
$startButton.Add_Click({
        $startButton.Enabled = $false
        $statusLabel.Text = "Iniciando processo..."
        Write-Log "Processo iniciado"

        $steps = @(
            "Passo 1: Preparando ambiente...",
            "Passo 2: Verificando arquivos...",
            "Passo 3: Conectando com o servidor...",
            "Passo 4: Executando tarefa principal...",
            "Passo 5: Finalizando ajustes...",
            "Passo 6: Limpando e finalizando..."
        )

        for ($i = 0; $i -lt $steps.Count; $i++) {
            $statusLabel.Text = $steps[$i]
            $form.Refresh()

            Write-Log $steps[$i]
            Start-Sleep -Seconds 2  # Simula tempo de execução

            # Aqui você pode colocar comandos reais

            $progressBar.Value = $i + 1
        }

        $statusLabel.Text = "Todos os passos foram concluídos!"
        Write-Log "Processo concluído"
        $startButton.Text = "Finalizado"
    })

# Mostrar janela
[void]$form.ShowDialog()
