while ($true) {
    Clear-Host 
    
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host "             SISTEMA DE MONITORIZACAO              " -ForegroundColor Yellow
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host "1. Ver Processos (Memoria e CPU)"
    Write-Host "2. Ver Espaco no Sistema de Ficheiros"
    Write-Host "3. Ver Portas Abertas (Seguranca)"
    Write-Host "4. Ver Servidores e Servicos Ativos"
    Write-Host "5. Testar Rede e Conectividade"
    Write-Host "0. Sair"
    Write-Host "===================================================" -ForegroundColor Cyan

    $opcao = Read-Host "Escolha uma opcao (0 a 5)"

    switch ($opcao) {
        '1' {
            Write-Host "`n--- PROCESSOS A CONSUMIR MAIS MEMORIA ---" -ForegroundColor Green
            Get-Process | Sort-Object WorkingSet -Descending | Select-Object Name, @{Name="Memoria(MB)";Expression={[math]::Round($_.WorkingSet / 1MB, 2)}} -First 5 | Out-Host
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '2' {
            Write-Host "`n--- ESPACO LIVRE NO DISCO (C:) ---" -ForegroundColor Green
            Get-Volume -DriveLetter C | Select-Object DriveLetter, @{Name="Livre(GB)";Expression={[math]::Round($_.SizeRemaining / 1GB, 2)}}, @{Name="Total(GB)";Expression={[math]::Round($_.Size / 1GB, 2)}} | Out-Host
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '3' {
            Write-Host "`n--- PORTAS ABERTAS ---" -ForegroundColor Green
            Get-NetTCPConnection -State Listen | Select-Object LocalAddress, LocalPort -First 5 | Out-Host
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '4' {
            Write-Host "`n--- SERVICOS EM EXECUCAO ---" -ForegroundColor Green
            Get-Service | Where-Object Status -eq 'Running' | Select-Object Name, DisplayName -First 10 | Out-Host
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '5' {
            Write-Host "`n--- TESTE DE REDE (PING) ---" -ForegroundColor Green
            ping 8.8.8.8
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