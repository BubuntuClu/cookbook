App.cable.subscriptions.create('ChatChannel', {
  connected: ->
    @perform 'follow_chat_messages', chat_id: gon.chat_id
  ,

  received: (data) ->
    if (data.author_id != gon.user_id)
      html_message = ('<div class="message">' +
        '<p class="author">' + data.author + '</p>' +
        '<p class="texst">' + data.message + '</p>' +
        '</div>')
      $('.messages').append(html_message)
})
