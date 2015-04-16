express = require 'express'

routes = (Book) ->
  console.log "FYI: book is",Book
  BookRouter = express.Router()
  BookController = require('../controllers/book_controller')(Book)

  BookRouter.route('/')
  .post(BookController.post)
  .get(BookController.get)

  BookRouter.use '/:bookId', (req, res, next) ->
    Book.findById req.params.bookId, (err, book) ->
      debugger
      if err
        res.status(500).send(err)
        return
      if book
        # stop and debug here
        req.book = book
        next()
      else
        res.status(404).send('no book found')

  BookRouter.route('/:bookId')
  .get (req, res) ->
    returnBook = req.book.toJSON()
    returnBook.links = {}
    newLink = 'http://' + req.headers.host + '/api/books/?genre=' + returnBook.genre
    returnBook.links.FilterByThisGenre = newLink.replace(' ', '%20')
    res.json(returnBook)

  .put (req, res) ->
    req.book.title = req.body.title
    req.book.author = req.body.author
    req.book.genre = req.body.genre
    req.book.read = req.body.read
    req.book.save (err) ->
      if err
        res.status(500).send(err)
      else
        res.json(req.book)

  .patch (req, res) ->
    if req.body._id
      delete req.body._id
    for p in req.body
      req.book[p] = req.body[p]

    req.book.save (err) ->
      if err
        res.status(500).send(err)
      else
        res.json(req.book)

  .delete (req, res) ->
    req.book.remove (err) ->
      if err
        res.status(500).send(err)
      else
        res.status(204).send('Removed')

  return BookRouter

module.exports = routes
