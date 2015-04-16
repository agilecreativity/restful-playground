var should = require('should'),
    request = require('supertest'),
    app = require('../app.js'),
    mongoose = require('mongoose'),
    Book = mongoose.model('Book'),
    agent = request.agent(app);

describe ('Book Crud Test', function() {
  it ('Should allow a book to be posted and return a read and _id', function(done) {
    var bookPost = {
      title:'Go In Action',
      author:'John Grisham',
      genre:'Programming',
      read: true
    };

    agent.post('/api/books')
    .send(bookPost)
    .expect(200)
    .end(function(err, results) {
      results.body.title.should.equal('Go In Action');
      results.body.author.should.equal('John Grisham');
      results.body.genre.should.equal('Programming');
      results.body.read.should.equal(true);
      results.body.should.have.property('_id');
      done()
    })
  })

  afterEach(function(done) {
    Book.remove().exec();
    done();
  })
})