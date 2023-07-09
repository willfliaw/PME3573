# E02 - BH-3 Ensaio de decaimento em ar

Neste diretório do Repositório PME3573, documentam-se as atividades realizadas para solução do exercício **E02 - BH-3 Ensaio de decaimento em ar**, cujo enunciado específico pode ser encontrado [aqui](./E02%20-%20BH-3%20Ensaio%20de%20decaimento%20em%20ar.pdf). Para mais informações referentes ao propósito geral do repositório, suposições iniciais, e demais conceitos preliminares, recomenda-se retornar à raiz do repositório para ler suas [especificações](../README.md).

## Índice

- [E02 - BH-3 Ensaio de decaimento em ar](#e02---bh-3-ensaio-de-decaimento-em-ar)
  - [Índice](#índice)
  - [Introdução](#introdução)
  - [Dados experimentais](#dados-experimentais)
  - [Relatório acadêmico](#relatório-acadêmico)
  - [Uso](#uso)
    - [Instalação de bibliotecas adicionais](#instalação-de-bibliotecas-adicionais)

## Introdução

Para estimular os alunos da Disciplina PME3573, foi proposto pelo docente Renato Matarazzo Orsino, exercício de análise de dados referentes ao decaimento do BH-3, especificamente das séries temporais das coordenadas cartesianas dos alvos refletivos no ensaio de decaimento em ar de um longo tubo flexível, engastado em sua extremidade superior e munido de um pequeno lastro metálico em sua extremidade inferior. Nesse viés propõe-se o estudo do bancos de dados e elaboração de relatório acadêmico dele resultante.

Aqui, o presente diretório funciona como resposta do Autor William Liaw ao exercício proposto. Elaborou-se, assim, código computacional na linguagem Python 3 o qual pode ser encontrado no arquivo [`E02-William Liaw.ipynb`](./E02-William%20Liaw.ipynb), um *Jupyter Notebook*.

## Dados experimentais

|         Arquivo          |
| :----------------------: |
| `./data/BH_03_AIR_1.csv` |

Ao longo deste trabalho, apelidará-se este banco de dados de **BH3**.

Os bancos de dados a serem analisados no presente Relatório foram disponibilizados pelos docentes da Disciplina. O ensaio que gerou tais dados pode ser observado em [vídeo](https://www.youtube.com/watch?v=xLj0xL4nBLU).

Para funcionamento adequado dos arquivos de código, é imprescindível:

- que se baixe o arquivo referentes ao banco de dados em si (`.csv`);
- que se nomeie este arquivo como indicado;
- e que se mova este arquivo para o diretório `./data`.

O não atendimento de todas as três condições acima impedirá a execução e teste dos códigos computacionais disponibilizados e, consequentemente, não será possível reproduzir os resultados atingidos. Ainda assim, será possível analisar os resultados no modo *read only*, seja pelo Jupyter instalado na máquina do usuário, seja pelo interpretador de Jupyter do GitHub, que, apesar de não ideal, ainda permite ao usuário leitura e análise de resultados idênticos àqueles obtidos pelo autor.

## Relatório acadêmico

Para elaboração do relatório acadêmico, exportou-se o *Jupyter Notebook* [`E01-William Liaw.ipynb`](./E01-William%20Liaw.ipynb) como `pdf`. O Autor recomenda a leitura diretamente no [*Jupyter Notebook*]((https://github.com/willfliaw/PME3573/blob/main/E01/E01-William%20Liaw.ipynb)).

## Uso

Para abrir o arquivo *Jupyter Notebook* deste exercício, basta executar os comandos:

```bash
conda activate rEnv
jupyter notebook './E02/E02-William Liaw.ipynb'
```

Uma vez aberto o *Jupyter Notebook*, pode-se executar as células sequencialmente para seguir os passos de resolução do autor.

### Instalação de bibliotecas adicionais

Para funcionamento integral do código é necessário instalar algumas bibliotecas adicionais. Estas bibliotecas não foram instaladas pelo gerenciador de pacotes do Anaconda/Miniconda, pois não constam nos repositórios, no presente momento (verificado e 14/06/2023). Assim, pode-se seguir o seguinte passo a passo para instalação:

1. Abrir um terminal R (ou radian)

   ```bash
   conda activate rEnv
   r.exe
   ```

2. Baixar e instalar bibliotecas (exemplo: `gplm`, `pls`):

   ```R
   install.packages("gplm");
   install.packages("pls");
   ```
