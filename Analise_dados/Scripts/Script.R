
library(tidyverse)
library(readxl)


dados <- read_excel("C:/Users/Vitória Alexandria/Downloads/db8c4f69-7d33-49b3-b0b8-929a28897875.xlsx", skip = 2)


colnames(dados) <- c("Data_Extracao", "Cod_Mun_Ocorrencia", 
                     "Cobertura_Vacinal_jan24", "Doses_Aplicadas_jan24", "Populacao_jan24",
                     "Cobertura_Vacinal_fev24", "Doses_Aplicadas_fev24", "Populacao_fev24",
                     "Cobertura_Vacinal_mar24", "Doses_Aplicadas_mar24", "Populacao_mar24",
                     "Cobertura_Vacinal_abr24", "Doses_Aplicadas_abr24", "Populacao_abr24",
                     "Cobertura_Vacinal_mai24", "Doses_Aplicadas_mai24", "Populacao_mai24",
                     "Cobertura_Vacinal_jun24", "Doses_Aplicadas_jun24", "Populacao_jun24",
                     "Cobertura_Vacinal_jul24", "Doses_Aplicadas_jul24", "Populacao_jul24",
                     "Cobertura_Vacinal_ago24", "Doses_Aplicadas_ago24", "Populacao_ago24",
                     "Cobertura_Vacinal_set24", "Doses_Aplicadas_set24", "Populacao_set24",
                     "Cobertura_Vacinal_out24", "Doses_Aplicadas_out24", "Populacao_out24")


dados_tidy <- dados %>% 
  pivot_longer(
    cols = -c(Data_Extracao, Cod_Mun_Ocorrencia),
    names_to = c(".value", "Mes_Ano"),
    names_sep = "_"
  )


View(dados_tidy)

names(dados) <- names(dados) %>%
  str_replace_all(" ", "_") %>%         
  str_replace_all("ç", "c") %>%         
  str_replace_all("ã", "a") %>%         
  str_replace_all("\\.\\.\\..*", "")   


names(dados)[3:length(names(dados))] <- paste0(names(dados)[3:length(names(dados))], "_", 
                                               rep(c("jan24", "fev24", "mar24", "abr24", "mai24", "jun24", 
                                                     "jul24", "ago24", "set24", "out24"), each=3))


print(colnames(dados))


dados_tidy <- dados %>%
  pivot_longer(
    cols = -c(Data_Extracao, Cod_Mun_Ocorrência), 
    names_to = c("Variavel", "Mes_Ano"),           
    names_pattern = "(.+)_(\\w{3}\\d{2})"           
  )


print(dados_tidy)


write_csv(dados_tidy, "dados_vacinacao_tidy.csv")


colnames(dados_tidy)
[1] "Data_Extracao"      "Cod_Mun_Ocorrência"
[3] "Variavel"           "Mes_Ano"           
[5] "value"             

  > dados_tidy %>%
  +     group_by(Variavel) %>%
  +     summarise(
    +         Media = mean(value, na.rm = TRUE),
    +         Mediana = median(value, na.rm = TRUE),
    +         Minimo = min(value, na.rm = TRUE),
    +         Maximo = max(value, na.rm = TRUE),
    +         Desvio_Padrao = sd(value, na.rm = TRUE)
    +     ) %>%
  +     print()

Variavel    Media Mediana Minimo Maximo Desvio_Padrao
<chr>       <dbl>   <dbl>  <dbl>  <dbl>         <dbl>
  1 Cobertura_…  130.    133.   114.   141.          9.99
2 Doses_Apli… 1172.   1197   1002   1246          79.8 
3 Populacao    903.    898.   807    982          47.5 
> 


  > ggplot(dados_tidy %>% filter(Variavel == "Cobertura Vacinal"), aes(x = Mes_Ano, y = value, group = Cod_Mun_Ocorrência, color = as.factor(Cod_Mun_Ocorrência))) +
  +     geom_line(aes(linewidth = 1), alpha = 0.7) +  # Agora usando 'linewidth' dentro de 'aes()' para evitar o aviso
  +     labs(title = "Evolução da Cobertura Vacinal por Município",
             +          x = "Mês/Ano",
             +          y = "Cobertura Vacinal (%)",
             +          color = "Município") +
  +     theme_minimal() +
  +     theme(axis.text.x = element_text(angle = 45, hjust = 1))
> 
  > dados_tidy$Mes_Ano <- factor(dados_tidy$Mes_Ano, levels = unique(dados_tidy$Mes_Ano))
> 


  > str(dados_tidy)
tibble [60 × 5] (S3: tbl_df/tbl/data.frame)
$ Data_Extracao     : POSIXct[1:60], format: "2025-01-27" "2025-01-27" ...
$ Cod_Mun_Ocorrência: chr [1:60] NA NA NA NA ...
$ Variavel          : chr [1:60] "Cobertura_Vacinal" "Doses_Aplicadas" "Populacao" "Cobertura_Vacinal" ...
$ Mes_Ano           : Factor w/ 10 levels "jan24","fev24",..: 1 1 1 2 2 2 3 3 3 4 ...
$ value             : num [1:60] 140 1245 887 136 1101 ...
> 

  > sum(is.na(dados_tidy))
[1] 30
> 

  > head(dados_tidy$Mes_Ano)
[1] jan24 jan24 jan24 fev24 fev24 fev24
Levels: jan24 fev24 mar24 abr24 mai24 jun24 jul24 ago24 set24 out24
> head(dados_tidy$value)
[1]  140.3608 1245.0000  887.0000  136.4312 1101.0000  807.0000

  > ggplot(dados_tidy, aes(x = Mes_Ano, y = value)) +
  +     geom_bar(stat = "identity", fill = "skyblue", alpha = 0.7) +
  +     labs(title = "Cobertura Vacinal ao Longo do Tempo",
             +          x = "Mês/Ano",
             +          y = "Cobertura Vacinal (%)") +
  +     theme_minimal() +
  +     theme(axis.text.x = element_text(angle = 45, hjust = 1))
> 
  > ggplot(dados_tidy, aes(x = Cobertura_Vacinal)) +
  +     geom_histogram(bins = 20, fill = "blue", alpha = 0.7) +
  +     labs(title = "Distribuição da Cobertura Vacinal",
             +          x = "Cobertura Vacinal (%)",
             +          y = "Frequência") +
  +     theme_minimal()
Error in `geom_histogram()`:
  ! Problem while computing aesthetics.
ℹ Error occurred in the 1st layer.
Caused by error:
  ! objeto 'Cobertura_Vacinal' não encontrado
Run `rlang::last_trace()` to see where the error occurred.
> # Histograma simples da Cobertura Vacinal
  > ggplot(dados_tidy %>% filter(Variavel == "Cobertura Vacinal"), aes(x = value)) +
  +     geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.7) +
  +     labs(title = "Distribuição da Cobertura Vacinal",
             +          x = "Cobertura Vacinal (%)",
             +          y = "Frequência") +
  +     theme_minimal()
> 
 
  > head(dados_tidy)

Data_Extracao       Cod_Mun_Ocorrência Variavel          Mes_Ano value
<dttm>              <chr>              <chr>             <fct>   <dbl>
  1 2025-01-27 00:00:00 NA                 Cobertura_Vacinal jan24    140.
2 2025-01-27 00:00:00 NA                 Doses_Aplicadas   jan24   1245 
3 2025-01-27 00:00:00 NA                 Populacao         jan24    887 
4 2025-01-27 00:00:00 NA                 Cobertura_Vacinal fev24    136.
5 2025-01-27 00:00:00 NA                 Doses_Aplicadas   fev24   1101 
6 2025-01-27 00:00:00 NA                 Populacao         fev24    807 
> 

  > sum(is.na(dados_tidy$value))
[1] 0
> 

  > dados_tidy <- dados_tidy %>% filter(!is.na(value))


  > ggplot(dados_tidy %>% filter(Variavel == "Cobertura Vacinal"), aes(x = Mes_Ano, y = value, fill = "skyblue")) +
  +     geom_bar(stat = "identity", alpha = 0.7) +
  +     labs(title = "Cobertura Vacinal por Mês/Ano",
             +          x = "Mês/Ano",
             +          y = "Cobertura Vacinal (%)") +
  +     theme_minimal() +
  +     theme(axis.text.x = element_text(angle = 45, hjust = 1))

  > unique(dados_tidy$Mes_Ano)
[1] jan24 fev24 mar24 abr24 mai24 jun24 jul24 ago24 set24 out24
Levels: jan24 fev24 mar24 abr24 mai24 jun24 jul24 ago24 set24 out24
> 

  > dados_tidy$Mes_Ano <- trimws(dados_tidy$Mes_Ano)
> 

  > head(dados_tidy)

Data_Extracao       Cod_Mun_Ocorrência Variavel          Mes_Ano value
<dttm>              <chr>              <chr>             <chr>   <dbl>
  1 2025-01-27 00:00:00 NA                 Cobertura_Vacinal jan24    140.
2 2025-01-27 00:00:00 NA                 Doses_Aplicadas   jan24   1245 
3 2025-01-27 00:00:00 NA                 Populacao         jan24    887 
4 2025-01-27 00:00:00 NA                 Cobertura_Vacinal fev24    136.
5 2025-01-27 00:00:00 NA                 Doses_Aplicadas   fev24   1101 
6 2025-01-27 00:00:00 NA                 Populacao         fev24    807 
> 

  > str(dados_tidy)
tibble [60 × 5] (S3: tbl_df/tbl/data.frame)
$ Data_Extracao     : POSIXct[1:60], format: "2025-01-27" "2025-01-27" ...
$ Cod_Mun_Ocorrência: chr [1:60] NA NA NA NA ...
$ Variavel          : chr [1:60] "Cobertura_Vacinal" "Doses_Aplicadas" "Populacao" "Cobertura_Vacinal" ...
$ Mes_Ano           : chr [1:60] "jan24" "jan24" "jan24" "fev24" ...
$ value             : num [1:60] 140 1245 887 136 1101 ...
> 
 
  > colnames(dados_tidy)
[1] "Data_Extracao"      "Cod_Mun_Ocorrência" "Variavel"          
[4] "Mes_Ano"            "value"             
> 
  
  > class(dados_tidy$value)
[1] "numeric"
> class(dados_tidy$Mes_Ano)
[1] "character"
> 

  > dados_tidy$Mes_Ano <- as.factor(dados_tidy$Mes_Ano)
> 

  > sum(is.na(dados_tidy$value))
[1] 0
> 

  > dados_tidy <- dados_tidy %>% filter(!is.na(value))




  > ggplot(dados_tidy %>% filter(Variavel == "Cobertura_Vacinal"), aes(x = value)) +
  +     geom_histogram(binwidth = 5, fill = "skyblue", color = "black", alpha = 0.7) +
  +     labs(title = "Distribuição da Cobertura Vacinal",
             +          x = "Cobertura Vacinal (%)",
             +          y = "Frequência") +
  +     theme_minimal()
> 

  > dados_correlacao <- dados_tidy %>%
  +     filter(Variavel %in% c("Doses_Aplicadas", "Populacao"))
> 

  > head(dados_correlacao)

Data_Extracao       Cod_Mun_Ocorrência Variavel        Mes_Ano value
<dttm>              <chr>              <chr>           <fct>   <dbl>
  1 2025-01-27 00:00:00 NA                 Doses_Aplicadas jan24    1245
2 2025-01-27 00:00:00 NA                 Populacao       jan24     887
3 2025-01-27 00:00:00 NA                 Doses_Aplicadas fev24    1101
4 2025-01-27 00:00:00 NA                 Populacao       fev24     807
5 2025-01-27 00:00:00 NA                 Doses_Aplicadas mar24    1086
6 2025-01-27 00:00:00 NA                 Populacao       mar24     951
> 

  > correlacao <- dados_correlacao %>%
  +     spread(Variavel, value) %>%
  +     summarise(correlacao = cor(Doses_Aplicadas, Populacao))
> 

  > print(correlacao)

correlacao
<dbl>
  1      0.203
> 
  > ggplot(dados_correlacao %>% spread(Variavel, value), aes(x = Populacao, y = Doses_Aplicadas)) +
  +     geom_point(color = "blue", alpha = 0.7) +
  +     labs(title = "Correlação entre Doses Aplicadas e População",
             +          x = "População",
             +          y = "Doses Aplicadas") +
  +     theme_minimal()

