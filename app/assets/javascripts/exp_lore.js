
function submit_message_form()
{
  var vkontakte_message = document.getElementById("vkontakte_message_text").value
  
  function send_vkontakte_message(vkontakte_message)
  {
    VK.init({
      apiId: 3756304
    });
    function authInfo(response) {
      if (response.session) {
        alert('user: '+response.session.mid);
      } else {
        alert('not auth');
      }
    }
    VK.Auth.getLoginStatus(authInfo);
    alert("1");
    VK.Api.call("wall.post", {message: vkontakte_message}, function(r) {alert("callback");})
    alert("2");
  }

  if(vkontakte_message.length > 0) {
    alert("> " + vkontakte_message);
    send_vkontakte_message(vkontakte_message);
  }
  
  document.message_form.submit();
}
