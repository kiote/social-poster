
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
      
  console.info "something"

window.submit_form = ->
  VK.Api.call "wall.post", message: "mesage", (r) -> alert "your note as far as far away published"  if r.response

window.trying = ->
  alert "trym try"
  VK.Api.call "wall.post", message: "mesage", (r) -> alert "your note as far as far away published"  if r.response
