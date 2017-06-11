{-# LANGUAGE OverloadedStrings, QuasiQuotes,
             TemplateHaskell, ViewPatterns #-}
 
module Application where
import Foundation
import Yesod
import Usuario
import Review
import Lista
import Cadastro
import Handlers
import Front

-- Application
mkYesodDispatch "Sitio" resourcesSitio
