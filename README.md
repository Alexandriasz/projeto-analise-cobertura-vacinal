# 📊 Análise da Cobertura Vacinal no Brasil

Este projeto tem como objetivo analisar a **cobertura vacinal** de determinadas vacinas no Brasil ao longo do tempo, utilizando dados do **DataSUS**. Através dessa análise, buscamos identificar padrões, tendências e possíveis desafios na imunização da população.


---

## 📊 **Etapas do Projeto**

### 1️⃣ **Obtenção dos Dados**
- Os dados foram obtidos do **DataSUS** e exportados para um arquivo CSV.
- As informações incluem:
  - **Mês/Ano** da vacinação.
  - **Código do município**.
  - **Cobertura vacinal** (% da população vacinada).
  - **Doses aplicadas**.
  - **População estimada**.

### 2️⃣ **Preparação dos Dados**
- Utilizamos **R** para realizar:
  - **Leitura do arquivo CSV**.
  - **Tratamento de valores faltantes**.
  - **Transformação dos dados** para o formato tidy (utilizando `tidyverse`).
  - **Correção de tipos de dados** (conversão de datas e fatores).

### 3️⃣ **Análises Realizadas**
- **Distribuição da Cobertura Vacinal**: Identificação da variação da cobertura ao longo dos meses.
- **Correlação entre População e Doses Aplicadas**: Avaliação da relação entre a população estimada e as doses aplicadas.
- **Visualização Gráfica**:
  - Gráficos de **barras** e **dispersão** para entender padrões.
  - Uso da biblioteca **ggplot2** para a construção dos gráficos.

### 4️⃣ **Conclusões**
- A análise permitiu identificar flutuações na cobertura vacinal ao longo do tempo.
- Municípios com **baixa cobertura** foram destacados para futuras investigações.
- A relação entre a população estimada e as doses aplicadas ajudou a verificar se as metas de vacinação estão sendo atingidas.

---

## ⚙️ **Como Reproduzir o Projeto**

### ✅ **Pré-requisitos**
Certifique-se de ter os seguintes softwares instalados:
- **R** (versão 4.0 ou superior)
- **RStudio**
- Bibliotecas necessárias: `tidyverse`, `ggplot2`, `dplyr`, `readr`

### 🚀 **Passos**
1. **Clone o repositório**:
   ```bash
   git clone https://github.com/Alexandriasz/projeto-analise-cobertura-vacinal.git

