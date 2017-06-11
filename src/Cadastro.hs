{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Cadastro where
import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text

import Database.Persist.Postgresql

formUsuario :: Form Usuario
formUsuario = renderDivs $ Usuario <$>
             areq textField "Nome" Nothing <*>
             areq textField "Email" Nothing <*>
             areq textField "Senha" Nothing

widgetLoginForm :: Route Sitio -> Enctype -> Widget -> Text -> Widget
widgetLoginForm x enctype widget y = $(whamletFile "templates/loginform.hamlet")

widgetForm :: Route Sitio -> Enctype -> Widget -> Text -> Widget
widgetForm x enctype widget y = $(whamletFile "templates/form.hamlet")

getLoginR :: Handler Html
getLoginR = do
             (widget, enctype) <- generateFormPost formUsuario
             defaultLayout $ do 
                 addStylesheet $ StaticR teste_css
                 widgetLoginForm LoginR enctype widget "Usuarios"
                 
postLoginR :: Handler Html
postLoginR = undefined

getCadastroR :: Handler Html
getCadastroR = do
             (widget, enctype) <- generateFormPost formUsuario
             defaultLayout $ do 
                 addStylesheet $ StaticR teste_css
                 widgetForm CadastroR enctype widget "Novo Usuário"

postCadastroR :: Handler Html
postCadastroR = do
                ((result, _), _) <- runFormPost formUsuario
                case result of
                    FormSuccess usuario -> do
                       runDB $ insert usuario 
                       defaultLayout [whamlet| 
                           <h1> Usuario cadastrado: #{usuarioNome usuario}. 
                       |]
                    _ -> redirect CadastroR