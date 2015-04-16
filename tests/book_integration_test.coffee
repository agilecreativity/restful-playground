should = require('should')
request = require('supertest')
chai = require('chai')
expect = chai.expect

app = require('../app.js')
mongoose = require('mongoose')
Book = mongoose.model('Book')
agent = request.agent(app)

describe 'Book Crud Test', ->
  it 'Should allow a book to be posted and return a read and _id', (done) ->
    # The input
    bookPost =
      title:'new Book'
      author:'Jon'
      genre:'Fiction',
      read: true

    # Now send the book a 'POST' using 'supertest'
    agent.post('/api/books')
    .send(bookPost)
    .expect(200)
    .end (err, results) ->
      expect(results.body.title).to.be.equal 'new Book'
      expect(results.body.author).to.be.equal 'Jon'
      expect(results.body.genre).to.be.equal 'Fiction'
      expect(results.body.read).to.be.true
      results.body.should.have.property('_id')
      done()

  afterEach (done) ->
    Book.remove().exec()
    done()
