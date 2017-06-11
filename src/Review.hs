{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Review where
import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text

import Database.Persist.Postgresql

formReview :: Form Review
formReview = undefined --renderDivs $ Review <$>
            --  areq textField "Texto" Nothing <*>
            --  areq intField "Nota" Nothing 

getReviewsR :: Handler Html
getReviewsR = undefined --do
            --  listaR <- runDB $ selectList [] []
            --  defaultLayout $ [whamlet|
            --      <h1> Reviews
            --      $forall Entity rid review <- listaR
            --         uid <- runDB $ get404 (reviewAutor review)
            --         <a href=@{ReviewR uid rid}> #{reviewFilme review} 
            --  |]

postReviewsR :: Handler Html
postReviewsR = undefined --do
                -- ((result, _), _) <- runFormPost formReview
                -- case result of
                --     FormSuccess review -> do
                --       runDB $ insert review
                --       defaultLayout [whamlet|
                --           <h1> Review inserido com sucesso. 
                --       |]
                --     _ -> redirect ReviewsR

postReviewR :: UsuarioId -> ReviewId -> Handler Html
postReviewR uid rid = undefined

getReviewR :: UsuarioId -> ReviewId -> Handler Html
getReviewR uid rid = undefined