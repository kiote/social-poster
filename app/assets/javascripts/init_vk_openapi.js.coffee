
window.send_especially_to_vkontakte = (vkontakte_message)->
  
  VK.init apiId: 3756304
  
  vkontakte_message = vkontakte_message.replace("<br>", "")
  
  console.log 'send_especially_to_vkontakte'
  
  if vkontakte_message.length > 0
    
    console.log 'msg > 0'
    
    # VK.Api.call "wall.post", message: "mesage", (r) -> alert "your note as far as far away published"  if r.response
    
    # VK.Api.call 'users.get', uids: 6492, fields: 'sex,photo_big',
      # (r)->
        # console.log('ug') if r.response

    # VK.Api.call "wall.post", message: vkontakte_message,
     # (r) -> console.log "msg is sent" if r.response