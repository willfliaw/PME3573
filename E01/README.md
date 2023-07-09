# E01 - Fluxo de Informação e Análise Visual de Dados

Neste diretório do Repositório PME3573, documentam-se as atividades realizadas para solução do exercício **E01 - Fluxo de Informação e Análise Visual de Dados**, cujo enunciado específico pode ser encontrado [aqui](./E01%20-%20Fluxo%20de%20Informação%20e%20Análise%20Visual%20de%20Dados.pdf). Para mais informações referentes ao propósito geral do repositório, suposições iniciais, e demais conceitos preliminares, recomenda-se retornar à raiz do repositório para ler suas [especificações](../README.md).

## Índice

- [E01 - Fluxo de Informação e Análise Visual de Dados](#e01---fluxo-de-informação-e-análise-visual-de-dados)
  - [Índice](#índice)
  - [Introdução](#introdução)
  - [Dados experimentais](#dados-experimentais)
    - [Casos e óbitos por município e data](#casos-e-óbitos-por-município-e-data)
    - [Microdados dos casos](#microdados-dos-casos)
  - [Relatório acadêmico](#relatório-acadêmico)
  - [Uso](#uso)

## Introdução

Para iniciar os alunos da Disciplina PME3573, foi proposto pelo docente Walter Ponge Ferreira, exercício de análise de dados referentes à epidemia de *Severe acute respiratory syndrome coronavirus* (SARS-Cov-19). Nesse viés propõe-se o estudo de dois bancos de dados e elaboração de relatório acadêmico dele resultante.

Aqui, o presente diretório funciona como resposta do Autor William Liaw ao exercício proposto. Elaborou-se, assim, código computacional na linguagem Python 3 o qual pode ser encontrado no arquivo [`E01-William Liaw.ipynb`](./E01-William%20Liaw.ipynb), um *Jupyter Notebook*.

## Dados experimentais

Os bancos de dados a serem analisados no presente Relatório podem ser encontrados em [Dados Abertos | Governo do Estado de São Paulo](https://www.saopaulo.sp.gov.br/planosp/simi/dados-abertos/). A seguir, em cada subseção, tem-se, para cada banco de dado, o *path* dos arquivos que devem ser baixados externamente.

Para funcionamento adequado dos arquivos de código, é imprescindível:

- que se baixe os arquivos referentes aos bancos de dados em si (`.csv`);
- que se nomeiem estes arquivos como indicado;
- e que se movam estes arquivos para o diretório `./data`.

O não atendimento de todas as três condições acima impedirá a execução e teste dos códigos computacionais disponibilizados e, consequentemente, não será possível reproduzir os resultados atingidos. Ainda assim, será possível analisar os resultados no modo *read only*, seja pelo Jupyter instalado na máquina do usuário, seja pelo interpretador de Jupyter do GitHub, que, apesar de não ideal, ainda permite ao usuário leitura e análise de resultados idênticos àqueles obtidos pelo autor.

### Casos e óbitos por município e data

Registro de casos e óbitos por município e data de notificação no Estado de São Paulo.

|                 Arquivo                  |                                                  Descrição                                                   |
| :--------------------------------------: | :----------------------------------------------------------------------------------------------------------: |
| `./data/20230418_Casos-e-obitos-ESP.csv` | [`./metadata/Dic.-dados_dados_covid_municipios_sp.pdf`](./metadata/Dic.-dados_dados_covid_municipios_sp.pdf) |

Ao longo deste trabalho, apelidará-se este banco de dados de **COMuDa**.

### Microdados dos casos

Base de dados com registros individualizados e anonimizados, detalhados com os seguintes campos: Notificações, Evolução, Confirmação do caso para COVID-19, Idade, Gênero, Doenças Preexistentes, Sintomas, Raça/Cor, Etnia, Município, Profissionais de Saúde.

|                     Arquivo                     |                                  Descrição                                   |
| :---------------------------------------------: | :--------------------------------------------------------------------------: |
| `./data/20230418_dados_covid_municipios_sp.csv` | [`./metadata/Dic-dados_microdados.pdf`](./metadata/Dic-dados_microdados.pdf) |

Ao longo deste trabalho, apelidará-se este banco de dados de **MiCa**.

## Relatório acadêmico

Para elaboração do relatório acadêmico, exportou-se o *Jupyter Notebook* [`E01-William Liaw.ipynb`](./E01-William%20Liaw.ipynb) como `pdf`. O Autor recomenda a leitura diretamente no [*Jupyter Notebook*]((https://github.com/willfliaw/PME3573/blob/main/E01/E01-William%20Liaw.ipynb)).

## Uso

Para abrir o arquivo *Jupyter Notebook* deste exercício, basta executar os comandos:

```bash
conda activate dataScience
jupyter notebook './E01/E01-William Liaw.ipynb'
```

Uma vez aberto o *Jupyter Notebook*, pode-se executar as células sequencialmente para seguir os passos de resolução do autor.
