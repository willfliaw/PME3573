<div id = "PME3573" align = "center">
  <br />
  <picture>
    <source media = "(prefers-color-scheme: dark)" srcset = "./images/Logo_Escola-Politécnica-Minerva-sem-fundo-vnegativa.png" alt = "Poli Logo" width = "200" />
    <img src = "./images/Logo_Escola-Politécnica-Minerva-sem-fundo.png" alt = "Poli Logo" width = "200" />
  </picture>
  <h1>Introdução à Ciência de Dados para Engenheiros (PME3573)</h1>
</div>

O presente repositório foi elaborado em resposta às atividades da **Disciplina Introdução à Ciência de Dados para Engenheiros (PME3573)**, exigidas para a aprovação. Por este repositório almeja-se: organizar de forma eficiente os diversos materiais elaborados em resolução aos exercícios propostos, responder claramente aos questionamentos suscitados e apresentar resultados, discussões, informações, dados à eles pertinentes.

## Índice

- [Índice](#índice)
- [Baixar e instalar](#baixar-e-instalar)
  - [Passo a passo](#passo-a-passo)
- [Uso](#uso)
- [Créditos](#créditos)
- [Licença](#licença)

## Baixar e instalar

Para utilizar os conteúdos do presente repositório é necessário que se instale [Python 3](https://www.python.org/), e suas dependências. Em outro momento, futuramente, serão impleentados códigos em [R](https://www.r-project.org/) e possivelmente em [Julia](https://julialang.org/). Além disso, recomenda-se veementemente a instalação de um editor de texto ou Ambiente de Desenvolvimento Integrado (IDE, *Integrated Development Environment*), tal qual o [VSCodium](https://vscodium.com/), e, ainda, de um gerenciador de pacotes [Anaconda](https://anaconda.org/), como o [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

Na seção de [Passo a passo](#passo-a-passo) a seguir, pressupõe-se, por parte do usuário, conhecimento e noções básicas de terminal, sobretudo no que tange à [GitHub CLI](https://cli.github.com/), e alguma distribuição de Anaconda instalada adequadamente no sistema.

### Passo a passo

1. Clone este repositório

   ```bash
   git clone https://github.com/willfliaw/PME3573.git
   ```

2. Acesse o diretório do projeto na linha de comando

   ```bash
   cd PME3573
   ```

3. Para executar, testar e contribuir com o material do projeto aqui presente, convém a criação de um ambiente virtual (*virtual environment*). Para tanto, existem diversas formas, dentre as quais se destacam:

   - Para o Exercício 01:

     1. Via arquivo `.yml`:

        ```bash
        conda env create --name dataScience --file ./environment_dataScience.yml
        ```

     2. Pela instalação individual das dependências necessárias:

        ```bash
         conda create -n dataScience -c conda-forge python ipykernel jupyter matplotlib numpy pandas SciencePlots seaborn tqdm sqlalchemy
        ```

   - Para o Exercício 02:

     1. Via arquivo `.yml`:

        ```bash
        conda env create --name rEnv --file ./environment_rEnv.yml
        ```

     2. Pela instalação individual das dependências necessárias:

        ```bash
        conda create -n rEnv -c conda-forge r-essentials r-base radian jupyter r-irkernel r-rmarkdown
        ```

## Uso

Uma vez instaladas as dependências do presente repositório, pode-se navegar e inspecionar cada uma das atividades e exercícios realizados, os quais constam separadamente documentados dentro de seu diretório específico no modelo `EXX`, em que $XX$ se trata do número correspondente à atividade (exemplo: $01$, $02$, ...).

- [E01 - Fluxo de Informação e Análise Visual de Dados](./E01/README.md)
- [E02 - BH-3 Ensaio de decaimento em ar](./E02/README.md)

## Créditos

Autor: William Liaw ([@willfliaw](https://github.com/willfliaw), NUSP: 11834011).


## Licença

[MIT](LICENSE)
