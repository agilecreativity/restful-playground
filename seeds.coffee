#!/usr/bin/env coffee
mongoose = require('mongoose')
db_uri = 'mongodb://localhost/books'
db = mongoose.connect(db_uri)
Book = require('./models/book')

do ->
  clearDb = require('mocha-mongoose')(db_uri)
  book = new Book
    title: 'MongoDB in Action'
    author: 'James Jones'
    genre: 'Programming'

  book.save (err, data) ->
    if err
      console.log(err)
      return
    console.log("Successfully insert data:" + data)

  Book.create
    title: 'NodeJS in Action'
    author: 'Jack London'
    genre: 'Programming'
    ,(err, data) ->
      if err
        console.log "Error creating a model", err
        return
      console.log "NodeJS in Action saved!:", data

  Book.create
    title: 'Start with Why'
    author: 'Simon Sinek'
    genre: 'Management'
    ,(err, data) ->
      if err
        console.log "Error creating a book", err
        return
      console.log "Start with Why saved!:", data
  console.log "Successfully save a sample seed data"
