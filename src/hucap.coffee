# Description
#   A hubot script that can deploy through capistrano!
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Sri Harsha Kappala <sriharsha.kappala@hotmail.com>

repos = [
  'app_one',
  'app_two'
]

module.exports = (robot) ->

  robot.respond /deploy (.+) to (.+)/i, (msg) ->
    repo = msg.match[1]
    environment = msg.match[2]
    if repo in repos
      msg.send "Attempting deploy..."
      msg.http("http://localhost:9393/deploy/#{repo}/#{environment}").get() (err, res, body) ->
        if res.statusCode == 404
          msg.send "Something went horribly wrong!"
        else
          msg.send "Successfully deployed!"
    else
      msg.send "Nope! I don't know what that is... Try deploying one of these " + repos.join(', ')

  robot.respond /what can you deploy/, (msg) ->
    msg.send "I can deploy " + repos.join(', ')
