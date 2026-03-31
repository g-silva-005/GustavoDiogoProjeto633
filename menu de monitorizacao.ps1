while ($true) {
    cls
    Write-Host ">>>>  SISTEMA DE MONITORIZACAO <<<< " -ForegroundColor Yellow
    Write-Host ""
    Write-Host "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" -ForegroundColor Cyan
    Write-Host "1. Ver Processos (Memoria e CPU)"
    Write-Host "2. Ver Espaco no Sistema de Ficheiros"
    Write-Host "3. Ver Portas Abertas (Seguranca)"
    Write-Host "4. Ver Servidores e Servicos Ativos"
    Write-Host "5. Testar Rede e Conectividade"
    Write-Host "6. Visualizar Logs do Sistema"
    Write-Host "0. Sair"
    Write-Host "-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-" -ForegroundColor Cyan
    Write-Host ""
    $opcao = Read-Host ">>>>> Escolha uma opcao " 

    switch ($opcao) {
        '1' {
            Write-Host "`n--- PROCESSOS A CONSUMIR MAIS MEMORIA ---" -ForegroundColor Green
            Get-Process | Sort-Object WorkingSet -Descending | Select-Object Name, @{Name="Memoria(MB)";Expression={[int]($_.WorkingSet / 1MB)}} -First 5 | Out-Host
            Read-Host "`nPressione ENTER para voltar ao menu..."
        }
        '2' {
            Write-Host "`n--- ESPACO LIVRE NO DISCO (C:) ---" -ForegroundColor Green
            Get-PSdrive C | Out-Host
	        Get-PSdrive E | Out-Host
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
        '6' {
            Write-Host "`n--- ULTIMOS LOGS DO SISTEMA ---" -ForegroundColor Green
            
            Get-WinEvent -LogName System -MaxEvents 5 | Select-Object TimeCreated, LevelDisplayName, ProviderName, Message | Format-Table -AutoSize
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