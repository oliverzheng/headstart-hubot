# Description:
#   A way to interact with the ReplyGIF.net API.
#
# Commands:
#   hubot reply <query> - The Original. Queries ReplyGIF.net for a gif matching tag <query> and returns a random reply.

module.exports = (robot) ->
  robot.respond /(reply)( me)? (.*)/i, (msg) ->
    replyMe msg, msg.match[3], (url) ->
      msg.send url

  robot.hear /^lol$/i, (msg) ->
    replyMe msg, 'clapping,laugh', (url) ->
      msg.send url

  robot.hear /^okay$/i, (msg) ->
    replyMe msg, 'okay', (url) ->
      msg.send url

  robot.hear /^no$/i, (msg) ->
    replyMe msg, 'no', (url) ->
      msg.send url

  robot.hear /^nope$/i, (msg) ->
    replyMe msg, 'nope', (url) ->
      msg.send url

  robot.hear /^yes$/i, (msg) ->
    replyMe msg, 'yes', (url) ->
      msg.send url

replyMe = (msg, query, cb) ->
  q = tag: query
  msg.http('http://replygif.net/api/gifs?api-key=39YAprx5Yi')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      if images?.length > 0
        image  = msg.random images
        cb "#{image.file}"

