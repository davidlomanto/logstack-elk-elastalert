# logstack-elk-elastalert

Passo a passo de como subir a stack da aplicação bookinfo, assim como o elasticsearch+fluentd+kibana para servidor de log e por fim, aplicação de alerta para o log (elastalert). Como configurar para enviar um alerta por email. 

Instruções(passo a passo):

  1. Subir aplicação e servidor de log:
      a. Abrir o terminal;
      b. Entrar como “Root user”;
      c. Executar o bash “start.sh” (comando: ./start.sh).

  2. Subir o elastalert:

      a. Para isso, é necessário configurar a regra de alerta que você desejar. (Maiores informações de como fazer, consultar a          documentação: https://elastalert.readthedocs.io/en/latest/ . Na parte “Writing Filters For Rules”, diz como determinar          o filtro do alerta.) Para essa aplicação, usamos o alerta do tipo “email”;
      
      b. Abrir o arquivo “frequency.yaml(na pasta elastalert/example_rules)”;
            i. Alterar num_events (número de eventos que ocorrer para emitir o alerta);
           ii. Alterar timeframe (janela de tempo para que se detecte os eventos e emita o alerta);
          iii. Alterar todos os outros campos com “[ ]”, ex.: “[email]” vai aparecer como “joaocleber@gmail.com” (tirando os                  colchetes e mantendo as aspas;
          
      c. Abrir o arquivo “autentication.yaml”;
            i. Alterar os campos conforme foi feito no item 2.b.iii.
            
      d. Depois de configurado os arquivos, executar o bash “startalert.sh” (comando: ./startalert.sh);

      e. Pronto! seu alerta vai estar funcionando!
         ps: note que durante a execução vai mostrar o que está acontecendo, caso queira acompanhar. 

  3. Clear (limpar tudo):
  
      a. Caso queira terminar tudo, basta rodar o bash "clean.sh" (comando ./clean.sh).
