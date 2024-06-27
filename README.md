Este projeto consiste em criar uma aplicação onde os usuários possam gerenciar seus filmes assistidos, podendo informar o título, ano de lançamento e gênero do filme. Além de adicionar, os usuários também podem listar e editar as informações.

CONFIGURAÇÃO E EXECUÇÃO
DATABASE
- abrir console, no site do Realtime Database
- criar / nomear projeto
- manter uma conta: default account for firebase
- selecionar o tipo do aplicativo: FLUTTER
- criar o projeto
- acessar opção 'realtime database' no menu de opções no canto esquerdo
- configurar banco de dados e tipo de segurança
- após banco criado, copia a url
- inserir 'http: ^1.2.1' nas dependências do projeto (.yaml)
- import do pacote http no arquivo .controller
- guardar a url do banco em uma variável baseUrl

Ao rodar o código pela opção 'run without debugging', será aberta a tela da aplicação que, se aberta com sucesso, o usuário poderá adicionar e listar seus filmes.
todos os itens da listagem serão gravados no banco criado anteriormente.

PRINTS DA APLICAÇÃO:
### BANCO REALTIME DATABASE ###
![image](https://github.com/anakrahl/listaFilmesMobile/assets/135769876/4633b8f1-d8ac-44cf-89a1-eb40788367f6)

### TELA DA APLICAÇÃO ###
![telafilmes](https://github.com/anakrahl/listaFilmesMobile/assets/135769876/717ca734-5365-47e8-b932-06934c15c396)

### ADICIONAR NOVO FILME ###
![addfilme](https://github.com/anakrahl/listaFilmesMobile/assets/135769876/40b63bfa-a7f4-4629-b3ee-bb3d0f2a2342)

### EDITAR FILME ###
![editfilme](https://github.com/anakrahl/listaFilmesMobile/assets/135769876/9d1cd17e-be07-4d55-9173-afb9d2d93fca)
