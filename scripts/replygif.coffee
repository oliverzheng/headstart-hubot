# Description:
#   Makes ReplyGif easier to use. See http://replygif.net.
#
# Dependencies:
#   "cheerio": ">= 0.9.2"
#
# Configuration:
#   None
#
# Commands:
#   hubot replygif <keyword> - Embeds random ReplyGif with the keyword.
#   hubot replygif me <keyword> - Same as `hubot replygif <keyword>`.
#
# Notes:
#   Modified for more entertainment.
#
# Author:
#   sumeetjain, meatballhat

cheerio = require 'cheerio'

module.exports = (robot) ->
  # Listen for a command to look up a ReplyGif by tag.
  robot.respond /replygif( me)? (\D+)/i, (msg) ->
    replyGifByTag(msg, msg.match[2])

  robot.hear /^lol$/i, (msg) ->
    replyGifByTag(msg, 'laugh')

  robot.hear /^(\w+\s?\w+?)$/i, (msg) ->
    replyGifByTag(msg, msg.match[1])

replyGifByTag = (msg, tag) ->
  msg
    .http("http://replygif.net/t/#{tagify(tag)}")
    .header('User-Agent: ReplyGIF for Hubot (+https://github.com/github/hubot-scripts)')
    .get() (err, res, body) ->
      if not err and res.statusCode is 200
        gifs = getGifs(body)
        if !gifs or gifs.length == 0
          return
        msg.send msg.random gifs

getGifs = (body) ->
  $ = cheerio.load(body)
  $('img.gif[src]').map (i, elem) ->
    elem.attribs.src.replace(/thumbnail/, 'i')

tagify = (s) ->
  s.toLowerCase().replace(/\s+/g, '-').replace(/[^-a-z]/g, '')
