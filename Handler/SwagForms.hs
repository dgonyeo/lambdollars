module Handler.SwagForms where

import Import
import Utils
import Yesod.Form.Bootstrap3

data SwagBuy = SwagBuy Int64

swagBuyForm :: Form SwagBuy
swagBuyForm = renderLambdollarsForm $ SwagBuy
    <$> areq intField (withSmallInput "Quantity") Nothing

swagSaveForm :: Form (Text,Text,Text,FileInfo,Double,Int64)
swagSaveForm = renderLambdollarsForm $ (,,,,,)
    <$> areq textField (withSmallInput "Name") Nothing
    <*> areq textField (withSmallInput "Short Description") Nothing
    <*> areq textField (withSmallInput "Long Description") Nothing
    <*> fileAFormReq "Upload an image"
    <*> areq doubleField (withSmallInput "Cost") Nothing
    <*> areq intField (withSmallInput "Amount in Stock") Nothing

prefillSwagSaveForm :: Text -> Text -> Text -> Double -> Int64 -> Form (Text,Text,Text,FileInfo,Double,Int64)
prefillSwagSaveForm n sd ld c a = renderLambdollarsForm $ (,,,,,)
    <$> areq textField (withSmallInput "Name") (Just n)
    <*> areq textField (withSmallInput "Short Description") (Just sd)
    <*> areq textField (withSmallInput "Long Description") (Just ld)
    <*> fileAFormReq "Upload an image"
    <*> areq doubleField (withSmallInput "Cost") (Just c)
    <*> areq intField (withSmallInput "Amount in Stock") (Just a)

saveSaleForm :: Int64 -> Double -> Bool -> Form (Int64,Double,Bool,Bool)
saveSaleForm num total comp = renderLambdollarsTableForm $ (,,,)
    <$> areq intField  (withSmallInput "Num Purchased") (Just num)
    <*> areq doubleField (withSmallInput "Total") (Just total)
    <*> areq checkBoxField (withSmallInput "Delete") (Just False)
    <*> areq checkBoxField (withSmallInput "Completed") (Just comp)
