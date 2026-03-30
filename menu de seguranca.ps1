while ($true) {
    cls
    Write-Host " -------------- SISTEMA DE GESTAO --------------" -ForegroundColor Yellow
    Write-Host "1. Monitorizacao de Recursos (CPU, RAM, Disco)"
    Write-Host "2. Gestao de Utilizadores e Grupos na AD"
    Write-Host "3. Executar Plano de Backup (Seguranca)"
    Write-Host "4. Repor Backup"
    Write-Host "0. Sair"
    Write-Host "-------------------------------------------------" -ForegroundColor Yellow

    $opcao = Read-Host "--> "

    switch ($opcao) {
        '1' {
            Write-Host "`n--- ESTADO DOS RECURSOS DO SISTEMA ---" -ForegroundColor Green
            
            $cpuStats = Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average
            $cpu = "{0:N2}" -f $cpuStats.Average
            
            # Usar formatação de string na expressão da RAM
            $mem = Get-CimInstance Win32_OperatingSystem | Select-Object @{Name="Uso_RAM";Expression={"{0:N2}" -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory) / $_.TotalVisibleMemorySize) * 100)}}
            
            Write-Host "Utilizacao de CPU: $cpu %"
            Write-Host "Utilizacao de RAM: $($mem.Uso_RAM) %"
                  
            Get-Volume -DriveLetter C | Select-Object @{Name="Disco";Expression={$_.DriveLetter}}, @{Name="Livre(GB)";Expression={"{0:N2}" -f ($_.SizeRemaining / 1GB)}} | Out-Host
            
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '2' {
            Write-Host "`n--- CRIACAO DE UTILIZADOR NA OU (atec.local) ---" -ForegroundColor Green
            
            $nome = Read-Host "Digite o nome do novo utilizador"
            $pass = Read-Host "Digite a password para o utilizador" -AsSecureString
            
            $dominio = "DC=atec,DC=local"
            $nomeOU = "CaixadeSapatos"
            $caminhoOU = "OU=$nomeOU,$dominio"
            
            Write-Host "A verificar/criar a OU '$nomeOU'..." -ForegroundColor Cyan
            try {
                New-ADOrganizationalUnit -Name $nomeOU -Path $dominio -ErrorAction Stop
            } catch {
                # Se a OU ja existir, ele ignora o erro e continua
            }
            
            Write-Host "A criar o utilizador $nome dentro da OU $nomeOU..." -ForegroundColor Cyan
            New-ADUser -Name $nome -SamAccountName $nome -AccountPassword $pass -Enabled $true -Path $caminhoOU
            
            Write-Host "`nUtilizador $nome criado no dominio atec.local dentro da OU $nomeOU com sucesso!" -ForegroundColor Yellow
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '3' {
            Write-Host "`n--- EXECUCAO DE BACKUP AUTOMATICO ---" -ForegroundColor Green
            $origem = "E:\Dados" 
            $destino = "E:\Backups_Projeto"
            
            if (!(Test-Path $destino)) { New-Item $destino -Type Directory | Out-Null }
            
            Write-Host "A copiar ficheiros..." -ForegroundColor Cyan
            Copy-Item $origem -Destination $destino -Recurse -Force
            
            Write-Host "Copia de seguranca concluida em $destino" -ForegroundColor Yellow
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '4' {
            Write-Host "`n--- REPOSICAO DE BACKUP ---" -ForegroundColor Green
            $origemBackup = "E:\Backups_Projeto\Dados" 
            $destinoRestauro = "E:\" 
            
            if (Test-Path $origemBackup) {
                Write-Host "A repor ficheiros do backup..." -ForegroundColor Cyan
                Copy-Item -Path $origemBackup -Destination $destinoRestauro -Recurse -Force
                Write-Host "Recuperacao concluida com sucesso! Os dados voltaram para C:\Dados." -ForegroundColor Yellow
            } else {
                Write-Host "Erro: Nao foi encontrado nenhum backup em $origemBackup para repor." -ForegroundColor Red
            }
            
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '0' {
            Write-Host "`nA fechar o sistema... Adeus!" -ForegroundColor Yellow
            Start-Sleep -Seconds 1
            exit
        }
        default {
            Write-Host "`nOpcao invalida! Tenta de novo." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}