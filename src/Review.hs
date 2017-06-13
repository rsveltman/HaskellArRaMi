{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Review where
import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text

import Database.Persist.Postgresql

formReview :: UsuarioId -> Form Review
formReview uid = renderDivs $ Review <$>
              areq textField "Texto" Nothing <*>
              areq intField "Nota" Nothing <*>
              areq (selectField filmes) "Filme" Nothing <*>
              pure uid
              
filmes = do
        filmes <- runDB $ selectList [] [Asc FilmeNome] 
        optionsPairs $ fmap (\filme -> (filmeNome $ entityVal filme, entityKey filme)) filmes
              

getReviewsR :: Handler Html
getReviewsR = do
              listaR <- runDB $ selectList [] []
              filmes <- sequence $ fmap (\r -> runDB $ get404 $ reviewFilme $ entityVal r) listaR
              revfil <- return $ Prelude.zip listaR filmes
              
              defaultLayout $ [whamlet|
                  <h1> Reviews
                  
                  $forall (Entity rid review, filme) <- revfil
                     <a href=@{ReviewR (reviewAutor review) rid}> #{filmeNome filme}
 
              |]
postReviewsR :: Handler Html
postReviewsR = undefined

-- postReviewsR :: Handler Html
-- postReviewsR = do
--                 uid <- toSqlKey $ decimal $ lookupSession "_ID"
--                 case uid of
--                   Nothing -> do
--                     defaultLayout [whamlet| <h1> Usuario não logado.|]
--                   Just uid -> do
--                     ((result, _), _) <- runFormPost $ formReview uid
--                     case result of
--                       FormSuccess review -> do
--                         runDB $ insert review
--                         defaultLayout [whamlet|
--                           <h1> Review inserido com sucesso. 
--                         |]
--                       _-> redirect ReviewsR

postReviewR :: UsuarioId -> ReviewId -> Handler Html
postReviewR uid rid = undefined

getReviewR :: UsuarioId -> ReviewId -> Handler Html
getReviewR uid rid = undefined
-- getReviewR :: UsuarioId -> ReviewId -> Handler Html
-- getReviewR uid rid = do
--                       review <- runDB $ get404 rid
--                       filme <- runDB $ selectFirst [FilmeId == reviewFilme review] []
--                       usuario <- runDB $ get404 uid
--                       let nota = "+" * reviewNota review
--                       defaultLayout [whamlet| 
--                           <h1> 
--                               #{filmeNome filme}
--                           <h6> 
--                               #{usuarioNome usuario}
--                           <p>
--                               #{nota}
--                               #{reviewTexto review}
--                       |]