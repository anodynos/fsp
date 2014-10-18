chai = require 'chai'
chai.use require 'chai-as-promised'
expect = chai.expect

fsp = require '../code/fsp'

describe "fsp returns a fulfilling promise `when` executing:", ->
  filename = "testfile.txt"
  hello = "Hello world"

  it "`fsp.writeFileP` a new text file", ->
    pr = fsp.writeFileP filename, hello, {encoding: 'utf8'}
    expect(pr).to.be.eventually.fulfilled

  it "`fs.exists` the new file", ->
    pr = fsp.existsP filename

    expect(pr).to.be.eventually.fulfilled
    expect(pr).to.be.eventually.true

  it "`fsp.readFileP` from the text file", ->
    pr = fsp.readFileP filename, {encoding: 'utf8'}
    expect(pr).to.be.eventually.fulfilled
    expect(pr).to.be.eventually.equal hello

  it "`fsp.unlinkP` deleting the text file", ->
    pr = fsp.unlinkP filename
    expect(pr).to.be.eventually.fulfilled

  it "NOT `fs.exists` the deleted file", ->
    pr = fsp.existsP filename
    expect(pr).to.be.eventually.fulfilled
    expect(pr).to.be.eventually.false

describe "fsp returns a rejecting promise `when` executing:", ->
  filename = 'foobar'

  it "`fsp.readFileP` a non existing file", ->
    pr = fsp.readFileP filename
    expect(pr).to.be.eventually.rejectedWith 'ENOENT'

  it "`fsp.unlinkP` deleting a non existing file", ->
    pr = fsp.unlinkP filename
    expect(pr).to.be.eventually.rejectedWith 'ENOENT'