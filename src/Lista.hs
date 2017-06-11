{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell #-}
 
module Lista where
import Yesod
import Foundation
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Applicative
import Data.Text

import Database.Persist.Postgresql

getListaR :: ListaId -> Handler Html
getListaR lid = undefined

postListaR :: ListaId -> Handler Html
postListaR lid = undefined

getListasR :: Handler Html
getListasR = undefined

postListasR :: Handler Html
postListasR = undefined

