# trellocard

Made for [Übersicht](http://tracesof.net/uebersicht/)

![A screenshot showing todo.txt-widget in action](https://github.com/guxsousa/trellocard/raw/master/screenshot.png "todo.txt widget")



## Requirements

The widget may require `jq` (a lightweight and flexible command-line JSON processor).


## Summary

<p align="left">
  <img src="https://d2k1ftgv7pobq7.cloudfront.net/meta/u/res/images/brand-assets/Logos/0099ec3754bf473d2bbf317204ab6fea/trello-logo-blue.png" width="25%">
</p>

This widget will display a chosen card from [Trello](https://trello.com)

Edit `index.coffee` accordingly.

Duplicate _calls_ and _methods_ to display more cards if necessary.



# Features

The ubersicht widget processes the information directly

```java
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
```

However, it can mine the information first, and then create an array to be displayed as following:
```sh
URL="https://api.trello.com/1/boards/$boardId/lists?fields=name&cards=open&card_fields=name&key=$apiKey&token=$token"

USER_AGENT="User-Agent: Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1535.3 Safari/537.36"

BOARD=$(curl -s $URL -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H "$USER_AGENT")

CATEGORY=$(echo "$BOARD")

echo "To Do :: TODAY"
echo "$CATEGORY" | jq '.[0].cards | .[].name'

```


# Acknowledgments

http://tracesof.net/uebersicht-widgets/#to-do-list
