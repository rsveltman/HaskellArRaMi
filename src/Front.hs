{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Front where
import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text
import Handlers

import Database.Persist.Postgresql

mkYesodDispatch "Sitio" resourcesSitio

-- para usar as imgs e necessario stack clean e depois stack build para o yesod criar as funcoes baseadas nos arquivos
-- haskell.jpg -> haskell_jpg

-- O lucius/cassius ficam no executavel
-- addStylesheet e addScript nao deixa css/js no executavel - nao precisa de toWidgetHead
getTesteR :: Handler Html
getTesteR = do
        defaultLayout $ do
            addStylesheet (StaticR teste_css)
            toWidgetHead [lucius|
                h2{
                    color : blue;
                }
                p{
                    color : red;
                }
                ul{
                    list-style : none;
                }
                li{
                    float : left;
                    padding : 5px;
                }
            |]
            toWidgetHead [julius|
                function ola(){
                    alert("Oi");
                }
            |]
            [whamlet|
                <ul>
                    <li>
                        <a href=@{Pag1R}> Pagina 1
                    <li>
                        <a href=@{Pag2R}> Pagina 2
                    <li>
                        <a href=@{Pag3R}> Pagina 3
                <br>
                <h1> 
                    _{MsgHello}
                    
                <p>
                    PARAGRAFO
                <button onclick="ola()">
                    Click
                    
                <img src=@{StaticR haskell_jpg}>
            |]
            

getPag1R :: Handler Html
getPag1R = do
    defaultLayout $ do
        [whamlet|
            <h1>
                BLA 1
            <a href=@{TesteR}> Voltar
        |]
        
getPag2R :: Handler Html
getPag2R = do
    defaultLayout $ do
        [whamlet|
            <h1>
                BLA 2
            <a href=@{TesteR}> Voltar
        |]
        
getPag3R :: Handler Html
getPag3R = do
    defaultLayout $ do
        [whamlet|
            <h1>
                BLA 3
            <a href=@{TesteR}> Voltar
        |]