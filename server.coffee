#!/usr/bin/env coffee
express = require 'express'
mongoose = require 'mongoose'
bodyParser = require 'body-parser'

if process.env.ENV == 'Test'
  db = mongoose.connect 'mongodb://localhost/books_test'
else
  db = mongoose.connect 'mongodb://localhost/books'

Book = require './models/book'
app = express()
port = process.env.PORT || 3000

app.use bodyParser.urlencoded({extended:true})
app.use bodyParser.json()

BookRouter = require('./routes/book_router')(Book)
app.use '/api/books', BookRouter
app.get '/', (req, res) -> res.send 'welcome to my API!'

app.listen port, ->
  console.log 'Gulp is running my app on  PORT: ' + port

module.exports = app
