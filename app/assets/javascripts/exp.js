
function popitup() {
  
  var url = "https://oauth.vk.com/authorize?client_id=3756304&scope=notify,wall,friends&redirect_uri=blank.html&display=page&v=5.0&response_type=token";
  var windowName = "authorise";
  
  newwindow=window.open(url,windowName,"height=200,width=150, menubar=yes,location=yes");
  
  alert("window location: " + window.location.toString());
  alert("newwindow location: " + newwindow.location.toString());
  
  //~ if (window.focus) {
    //~ newwindow.focus()
    //~ 
    //~ alert("newwindow location: " + newwindow.location.toString());
    //~ TheNewWin.moveTo(50,50);
    //~ 
    //~ if (newwindow.location.toString().indexOf("blank.html") != -1) {
      //~ alert("found right location")
    //~ }
  //~ }
  return true;
};

//~ alert("exp.js");
