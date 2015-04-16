bookController = (Book) ->

  post: (req, res) ->
    book = new Book(req.body)

    if !req.body.title
      res.status(400)
      res.send('Title is required')
    else
      book.save()
      res.status(201)
      res.send(book)

  get: (req, res) ->
    query = {}
    if req.query.genre
      query.genre = req.query.genre

    Book.find query, (err, books) ->
      if err
        res.status(500).send(err)
      else
        returnBooks = []
        for element, index in books
          newBook = element.toJSON()
          console.log newBook
          newBook.links = {}
          newBook.links.self = 'http://' + req.headers.host + '/api/books/' + newBook._id
          returnBooks.push(newBook)
        res.json(returnBooks)
module.exports = bookController
