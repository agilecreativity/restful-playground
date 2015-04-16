sinon = require('sinon')
chai = require('chai')
expect = chai.expect

describe 'Book Controller Tests:', ->
  describe 'Post', ->
    it 'should not allow an empty title on post', ->
      Book = (book) ->
        @.save = ->
      req =
        body:
          author: 'Jon'
      res =
        status: sinon.spy()
        send: sinon.spy()

      BookController = require('../controllers/book_controller')(Book)
      BookController.post(req, res)
      expect(res.status.calledWith(400)).to.be.deep.equal(true, 'Bad Status ' + res.status.args[0][0])
      expect(res.send.calledWith('Title is required')).to.be.true
