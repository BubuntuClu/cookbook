App.cable.subscriptions.create('ChatChannel', {
  connected: ->
    console.log 'connected'
  ,

  received: (data) ->
    alert(1);
})
