#=============================================================================
#
#          FILE: Trello Widget
#
#   DESCRIPTION: Fetches trello information from a chosen card and
#                displays it as a string, which is used in übersicht.
#
#         NOTES: ---
#        AUTHOR: @github/guxsousa
#
#=============================================================================


# [1] : Setup TRELLO parameters ----------------------------------------------

# Get your Trello API Key here: https://trello.com/1/appKey/generate

apiKey = YOURTRELLOAPIKEY

# Authorize the API key and get a token https://trello.com/1/authorize?key=YOURTRELLOAPIKEY&name=Ubersicht+Trello+Widget&expiration=never&response_type=token

token = 'YOURTRELLOTOKEN'

# Get your Board Id by navigating to the Board you want in Trello.
# Take the url address, and copy the parameter after /b/ and before
# the last name, which is probably the name of the Board.
# It usually is an alphanumeric string (e.g. 2d3ajz18)

boardId = 'YOURBOARDID'

# Finally enter the name of the list you want to display in ubersicht

listName: 'YOURLISTNAME'




# [2] : Retrieve Trello information ------------------------------------------

command: "curl -s 'https://api.trello.com/1/boards/#{boardId}/lists?fields=name&cards=open&card_fields=name&key=#{apiKey}&token=#{token}'"
refreshFrequency: 10000




# [3] : Display Trello information in ubersicht ------------------------------

update: (output, domEl) ->
  data  = JSON.parse(output)
  for list of data
    listData = data[list] if data[list].name is this.listName
  $domEl = $(domEl)
  $domEl.html("<div class='entry listName'>#{listData.name}</div>")

  for item in listData.cards
    $domEl.append @renderItem(item)

renderItem: (data) ->
  """
    <div class='entry'>▪︎ #{data.name}</div>
  """

style: """
  top: 45%
  left: 0.2%
  font-size: 1.3em
  color: #ffffff
  font-family: EBMain
  text-align: left
  padding: 4px 4px 4px 4px
  width: 160

  .entry
    background-color: black
    background: rgba(#fff, 0.0)
    opacity .7
    border-radius 5px
    margin-bottom 2px
  .listName
    font-size: 1.6em
    background: rgba(#fff, 0.3)
"""

# ----------------------------------------------------------------------------
