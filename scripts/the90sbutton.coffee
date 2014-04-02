# Description:
#   Ushers the backstreet 90's back, alright?
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot everybody now - Embeds random 90's Youtube music video.
#
# Notes:
#   None

module.exports = (robot) ->
  # Listen for a command to push the 90s button
  robot.hear /^every[ ]?body now$/i, (msg) ->
    pushThe90sButton(msg, "yeaaah-ah!")

  robot.hear /^stop right now$/i, (msg) ->
    pushThe90sButton(msg, "thank you very much!")

  robot.hear /jiggy/i, (msg) ->
    pushThe90sButton(msg, "nah naah nah nah na naah na!")

  robot.hear /s club/i, (msg) ->
    pushThe90sButton(msg, "it's an s club party!")

  robot.hear /stand up/i, (msg) ->
    pushThe90sButton(msg, "please stand up. please stand up.")

pushThe90sButton = (msg, zinger) ->
  msg
    .http("http://the90sbutton.com/php/index.php/playlist")
    .header('User-Agent: the 90s button for Hubot')
    .get() (err, res, body) ->
      if not err and res.statusCode is 200
        videos = JSON.parse(body)
        if !videos or videos.length == 0
          return
        video = msg.random videos
        msg.send zinger + " it's 90's time! http://youtube.com/watch?v=" + video.youtubeid
