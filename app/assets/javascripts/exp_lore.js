
function submit_message_form()
{
  var vkontakte_message = document.getElementById("vkontakte_message_text").value
  
  vkontakte_message = vkontakte_message.replace("<br>","");
  
  function send_vkontakte_message(vkontakte_message)
  {
    VK.init({
      apiId: 3756304
    });
    
    VK.Api.call("wall.post", {message: vkontakte_message}, function(r) {alert("callback");})
    
    //~ VK.Auth.login
    //~ function authInfo(response) {
      //~ if (response.session) {
        //~ VK.Api.call("wall.post", {message: vkontakte_message}, function(r) {alert("callback");})
      //~ } else {
        //~ alert('not auth');
      //~ }
    //~ }
//~ 
    //~ VK.Auth.getLoginStatus(authInfo);
  }

  if(vkontakte_message.length > 0) {
    send_vkontakte_message(vkontakte_message);
    alert("okay");
  }
  
  document.message_form.submit();
}
