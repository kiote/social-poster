
window.vkAsyncInit = function() {
  VK.init({
    apiId: 3756304
  });
  
  VK.Api.call('users.get', {uids: id, fields: 'sex,photo_big'}, function(r) {
      if(r.response) {
          alert(r.response.sex);
          console.log(r.response);
      }
  });
  
  VK.Api.call('users.get', {uids: 6492, fields: 'sex,photo_big'},
     function(r) {
      if(r.response) {
        alert('Привет, ' + r.response[0].first_name);
        console.log(r.response);
      }
      else {
        alert(123123);
      }
    });
};

setTimeout(function() {
  var el = document.createElement("script");
  el.type = "text/javascript";
  el.src = "http://vk.com/js/api/openapi.js";
  el.async = true;
  document.getElementById("vk_api_transport").appendChild(el);
}, 0);
