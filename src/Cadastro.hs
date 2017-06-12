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

formLogin :: Form (Text, Text)
formLogin = renderDivs $ (,) <$>
             areq emailField "E-mail" Nothing <*>
             areq passwordField "Senha" Nothing

widgetLoginForm :: Route Sitio -> Enctype -> Widget -> Text -> Widget
widgetLoginForm x enctype widget y = $(whamletFile "templates/loginform.hamlet")

widgetForm :: Route Sitio -> Enctype -> Widget -> Text -> Widget
widgetForm x enctype widget y = $(whamletFile "templates/form.hamlet")

getLoginR :: Handler Html
getLoginR = do
             (widget, enctype) <- generateFormPost formLogin
             defaultLayout $ do 
                 addStylesheet $ StaticR teste_css
                 widgetLoginForm LoginR enctype widget "Usuario"
                 
postLoginR :: Handler Html
postLoginR = do
                ((result, _), _) <- runFormPost formLogin
                case result of
                    FormSuccess ("root@root.com","root2") -> do
                        setSession "_USER" "admin"
                        redirect ReviewsR
                    FormSuccess (email,senha) -> do
                       temUsu <- runDB $ selectFirst [UsuarioEmail ==. email, UsuarioSenha ==. senha] []
                       case temUsu of
                           Nothing -> do
                               setMessage [shamlet| <p> Usuário ou senha inválido |]
                               redirect LoginR
                           Just _ -> do
                               setSession "_USER" email
                               defaultLayout [whamlet| Usuário autenticado!|]
                    _ -> do
                        redirect LoginR

postLogoutR :: Handler Html
postLogoutR = do
    deleteSession "_USER"
    redirect LoginR

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