
window.send_especially_to_vkontakte = (vkontakte_message)->
  
  VK.init apiId: 3756304
  console.info "it seems that VK.api initialized"
  
  vkontakte_message = vkontakte_message.replace("<br>", "")
  
  if vkontakte_message.length > 0
    VK.Api.call "wall.post", message: vkontakte_message,
     (r) -> return "msg is sent" if r.response