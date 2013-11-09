
# include openapi.js

setTimeout (->
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "http://vkontakte.ru/js/api/openapi.js"
  document.getElementsByTagName("head")[0].appendChild script
), 0

# additional functions

authInfo = (response) ->
  if response.session
    alert "user: " + response.session.mid
  else
    alert "not auth"

# initialize app asynchronously

window.vkAsyncInit = ->  
  VK.init apiId: 3756304
  console.info "it seems that VK.api initialized"
  # VK.Auth.getLoginStatus authInfo
      
window.send_especially_to_vkontakte = ->
  
  vkontakte_message = document.getElementById("vkontakte_message_text").value
  vkontakte_message = vkontakte_message.replace("<br>", "")
  
  if vkontakte_message.length > 0
    VK.Api.call "wall.post", message: vkontakte_message, (r) -> return "msg is sent" if r.response
