# GustavoDiogoProjeto633

# 🛠️ Scripts de Administração e Monitorização Windows (PowerShell)

Este repositório contém dois scripts interativos desenvolvidos em **PowerShell** para automatizar tarefas diárias de administração de sistemas Windows, gestão de Active Directory e monitorização de recursos.

---

## 📋 Funcionalidades

### 🛡️ Menu de Gestão e Segurança (`menu de seguranca.ps1`)
Um menu focado na gestão do sistema e proteção de dados:
* **Monitorização Básica:** Verifica rapidamente a percentagem de uso de CPU, RAM e o espaço livre no disco C:.
* **Gestão Active Directory:** Permite a criação automatizada de novos utilizadores na Organizational Unit (OU) `CaixadeSapatos` dentro do domínio `atec.local`.
* **Backup de Dados:** Executa cópias de segurança forçadas da diretoria `E:\Dados` para `E:\Backups_Projeto`.
* **Restauro de Backup:** Repõe os dados previamente guardados no backup para a sua localização original.

### 📊 Menu de Monitorização (`menu de monitorizacao.ps1`)
Um menu dedicado à análise de performance, segurança e rede:
* **Processos:** Lista os 5 processos que estão a consumir mais memória RAM no momento.
* **Armazenamento:** Verifica o estado e o espaço livre nos discos locais (C: e E:).
* **Segurança:** Identifica e lista as primeiras 5 portas TCP que estão abertas (em estado *Listen*) no sistema.
* **Serviços:** Apresenta os primeiros 10 serviços do Windows que se encontram em execução.
* **Conectividade:** Realiza um teste de rede rápido (Ping para o DNS da Google - 8.8.8.8).
* **Logs do Sistema:** Mostra os 5 eventos mais recentes registados no log de Sistema (*System*) do Windows.

---

## ⚙️ Pré-requisitos
Para garantir que todas as opções funcionam corretamente, o ambiente onde os scripts vão correr deve ter:
* Sistema Operativo **Windows** com permissões de Administrador.
* Módulo de **Active Directory** do PowerShell instalado (necessário para a opção 2 do Menu de Segurança).
* Um domínio AD configurado como `atec.local` e uma OU chamada `CaixadeSapatos` (ou edita as variáveis `$dominio` e `$nomeOU` no código para o teu ambiente).
* Uma partição ou disco **E:** com a pasta `E:\Dados` criada, para testar as opções de backup.

## 🚀 Como Executar
1. Faz clone deste repositório para a tua máquina local.
2. Abre a consola do PowerShell (de preferência como Administrador).
3. Navega até à pasta onde guardaste os scripts e executa o menu pretendido:
   ```powershell
   .\menu de seguranca.ps1
   # ou
   .\menu de monitorizacao.ps1
