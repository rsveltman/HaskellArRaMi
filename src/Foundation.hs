{-# LANGUAGE OverloadedStrings, TypeFamilies, QuasiQuotes,
             TemplateHaskell, GADTs, FlexibleContexts,
             MultiParamTypeClasses, DeriveDataTypeable,
             GeneralizedNewtypeDeriving, ViewPatterns #-}
module Foundation where
import Yesod
import Yesod.Static
import Data.Text
import Database.Persist.Postgresql
    ( ConnectionPool, SqlBackend, runSqlPool, runMigration )

data Sitio = Sitio {getStatic :: Static, connPool :: ConnectionPool }

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Departamento
   nome Text
   sigla Text sqltype=varchar(3)
   deriving Show

Pessoa
   nome Text
   idade Int
   salario Double
   deptoid DepartamentoId
   deriving Show
   
   
Usuario
    nome Text
    email Text
    senha Text
    
Categoria
    nome Text

Filme
    nome Text
    diretor Text
    ator Text
    --ano Day
    pais Text
    categoria CategoriaId
    
Review
    texto Text
    nota Int
    filme FilmeId
    autor UsuarioId
    
Lista
    nome Text
    autor UsuarioId

Listafilme
    filme FilmeId
    lista ListaId
    
|]

staticFiles "static"

mkYesodData "Sitio" $(parseRoutesFile "config/routes")

mkMessage "Sitio" "messages" "pt-br"

instance YesodPersist Sitio where
   type YesodPersistBackend Sitio = SqlBackend
   runDB f = do
       master <- getYesod
       let pool = connPool master
       runSqlPool f pool

instance Yesod Sitio where

type Form a = Html -> MForm Handler (FormResult a, Widget)

instance RenderMessage Sitio FormMessage where
    renderMessage _ _ = defaultFormMessage