# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

sp_welcome = (x) -> alert("static_pages: sp_welcome")

sp_welcome(3)

submit_form = (message) -> alert(message)

# include openapi.js
setTimeout (->
  script = document.createElement("script")
  script.type = "text/javascript"
  script.src = "http://vkontakte.ru/js/api/openapi.js?3"
  document.getElementsByTagName("head")[0].appendChild script
), 0

# initialize app asynch
window.vkAsyncInit = ->
  
  VK.init apiId: 3756304
  
  alert("VK inits")
  
  vkontakte_message = document.getElementById("vkontakte_message_text").value
  vkontakte_message = vkontakte_message.replace("<br>", "")
  
  if vkontakte_message.length > 0
    alert("message > 0")
    VK.Api.call "wall.post", message: "mesage", (r) -> alert "your note as far as far away published"  if r.response

setTimeout (->
  el = document.createElement("script")
  el.type = "text/javascript"
  el.src = "[http://vkontakte.ru/js/api/openapi.js]"
  el.async = true
  document.getElementById("vk_api_transport").appendChild el
), 0