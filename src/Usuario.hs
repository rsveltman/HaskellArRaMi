{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Usuario where
import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text

import Database.Persist.Postgresql

getUsuarioR :: UsuarioId -> Handler Html
getUsuarioR uid = do
             usuario <- runDB $ get404 uid 
             -- pegar lista de reviews com uid como fk
             listaReviews <- runDB $ selectList [ReviewAutor ==. uid] []
             filmes <- sequence $ fmap (\r -> runDB $ get404 $ reviewFilme $ entityVal r) listaReviews 
             revfil <- return $ Prelude.zip listaReviews filmes
             defaultLayout [whamlet| 
                <h1> Reviews de #{usuarioNome usuario}
                    listaReviews
                -- colocar lista de reviews
                 $forall (Entity rid review, filme) <- revfil
                     <a href=@{ReviewR uid rid}> #{filmeNome filme} -- Usando join para pegar o nome do filme 
             |]