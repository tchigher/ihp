{-# LANGUAGE  UndecidableInstances, OverlappingInstances #-}

module TurboHaskell.HtmlSupport.ToHtml where
import qualified Text.Blaze.Html5              as Html5
import qualified Text.Blaze.Internal
import ClassyPrelude
import Data.String.Conversions (cs)
import TurboHaskell.View.ConvertibleStrings ()
import qualified Data.ByteString
import Prelude (String)

class ToHtml a where
    toHtml :: a -> Html5.Html

instance ToHtml (Text.Blaze.Internal.MarkupM ()) where
    {-# INLINE toHtml #-}
    toHtml a = a

instance ToHtml Text where
    {-# INLINE toHtml #-}
    toHtml = cs

instance ToHtml String where
    {-# INLINE toHtml #-}
    toHtml = cs

instance ToHtml Data.ByteString.ByteString where
    {-# INLINE toHtml #-}
    toHtml value = toHtml (cs value :: Text)

instance Show a => ToHtml (Maybe a) where
    {-# INLINE toHtml #-}
    toHtml maybeValue = maybe mempty toHtml maybeValue

instance Show a => ToHtml a where
    {-# INLINE toHtml #-}
    toHtml value = cs (show value)

