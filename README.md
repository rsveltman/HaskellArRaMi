# HASKELL ArRaMi

# dar isAuthorized para Static

#### REPOSITORIOS
- github: https://github.com/rsveltman/HaskellArRaMi.git -- nome: **origin**
- gitlab:  https://RSOV@gitlab.com/RSOV/HaskellArRaMi.git -- nome: **gitlab**

#### RODAR O SERVIDOR
Para rodar, o comando é `stack exec ayesod` dentro do diretorio trabalho.
Acesse a aplicação temporária em (haskraarmi-romefeller.c9users.io/).

#### USUARIOS
Atualmente o usuario e email globais são meus. 
Ate encontrar uma solucao melhor, quando for fazer um commit, o comando seguinte permite mudar temporariamente o usuario:
`git commit --author="Fulano de Tal <fulano@tal.org>"`

#### PROCEDIMENTO PARA A CRIAÇÃO DE TABELAS NO YESOD
1. Faz tabela no Foundation.hs
2. Define rota no routes
3. Cria arquivos .hs no diretório src, atualiza o cabal e importa no application.hs
4. Fazer no Handlers.hs:
    `postAlunoR :: Handler TypedContent
    postAlunoR = undefined`


#### ESCOPO
- Site de reviews de filmes. O usuário se inscreve, publica reviews e pode criar listas de filmes.
- A princípio não inclui: 
  - opção de um usuário seguir o outro
  - opção de mais de um usuário serem autores da mesma listaID
  - área de comentários

#### BANCO DE DADOS
- USUARIO
  - nome
  - email
  - senha
- FILME
  - nome
  - categoriaID - fk
  - diretor
  - ator principal
  - ano
  - pais
- REVIEW
  - texto
  - usuarioID - fk
  - nota
- LISTA
  - nome
  - usuarioID - fk
- LISTAFILMES
  - listaID - fk
  - filmeID - fk
- CATEGORIA
  - nome
   