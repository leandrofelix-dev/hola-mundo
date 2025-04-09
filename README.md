# 🎮 Hola Mundo - Jogo Narrativo em Godot

Este projeto é um jogo narrativo desenvolvido com o Godot Engine. O jogador assume o papel de Pedro, um candidato a uma vaga de emprego, e deve interagir com personagens e completar tarefas para avançar na história.

## 🎯 Objetivo do Jogo

O objetivo principal do jogo é ajudar Pedro a completar desafios e interagir com os personagens para garantir sua vaga na empresa. O jogador deve realizar tarefas como preencher formulários e conversar com outros personagens para progredir.

## 🛠️ Estrutura do Projeto

### Principais Cenas e Scripts

- **`rh.gd`**: Script principal que gerencia a interação com o personagem de Recursos Humanos (RH). Ele lida com diálogos, exibição de formulários e processamento de pontuações.
- **`dialog.tscn`**: Cena usada para exibir diálogos na interface do usuário.
- **`form.tscn`**: Cena usada para exibir o formulário de consentimento que o jogador deve preencher.

### Fluxo de Jogo

1. **👋 Interação Inicial**: Pedro inicia uma conversa com Maria, a gerente de contratação.
2. **📝 Preenchimento do Formulário**: O jogador preenche um formulário de consentimento.
3. **⭐ Pontuação**: A pontuação é calculada com base nas respostas corretas do formulário.
4. **➡️ Próximos Passos**: Maria orienta Pedro a encontrar sua supervisora, Jessika, para continuar o processo.

## ✨ Funcionalidades

- **💬 Diálogos Dinâmicos**: Diálogos são exibidos sequencialmente com tempos configuráveis.
- **📄 Formulário Interativo**: O jogador interage com um formulário que emite um sinal (`form_completed`) ao ser concluído.
- **📊 Pontuação**: A pontuação é calculada com base no desempenho do jogador e exibida na interface.
- **🔗 Conexão de Sinais**: O script utiliza sinais para gerenciar eventos, como a conclusão do formulário.

## 🧩 Estrutura do Código

### Principais Funções

- **`_ready()`**: Configura conexões iniciais e verifica a presença de nós necessários.
- **`_on_body_entered(body)`**: Inicia os diálogos quando Pedro interage com o personagem de RH.
- **`show_form(ui_layer)`**: Exibe o formulário de consentimento e conecta o sinal `form_completed`.
- **`_on_form_completed(acertos, total_perguntas)`**: Processa a pontuação e exibe os próximos diálogos após a conclusão do formulário.

### Logs de Depuração

O código inclui várias mensagens de depuração para ajudar a identificar problemas, como:
- Verificação de nós (`current_scene`, `UI`).
- Conexão de sinais (`form_completed`).
- Instanciação de cenas (`dialog_scene`, `report_scene`).

## 🚀 Como Executar

1. Abra o projeto no Godot Engine.
2. Execute a cena principal para iniciar o jogo.
3. Siga as instruções na tela para interagir com os personagens e completar as tarefas.

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

## 📜 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
