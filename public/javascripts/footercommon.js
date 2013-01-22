
$(document).ready(function(){function megaHoverOver(){$(this).find(".sub").show();$(this).find("a.nav").addClass("menuHover");$(this).find("a.navLink1").addClass("menuHover");}
function megaHoverOut(){$(this).find(".sub").hide();$(this).find("a.nav").removeClass("menuHover");$(this).find("a.navLink1").removeClass("menuHover");}
var config1={sensitivity:1,interval:10,over:megaHoverOver,timeout:20,out:megaHoverOut};$("ul#topnav li").hoverIntent(config1);function sideHoverOver(){$(this).find(".sideMenu").show();$(this).addClass("sideArrowHover");}
function sideHoverOut(){$(this).find(".sideMenu").hide();$(this).removeClass("sideArrowHover");}
var config2={sensitivity:1,interval:0,over:sideHoverOver,timeout:0,out:sideHoverOut};$("ul#sideNav li").hoverIntent(config2);});$(document).ready(function(){var configMinicart={sensitivity:1,interval:10,over:function(){$(".my_cart").css('background-position','-373px -134px');$("#minicart").slideDown(100);},timeout:300,out:function(){$("#minicart").slideUp(100);$(".my_cart").css('background-position','-373px -104px');}};$(".my_cart").hoverIntent(configMinicart);$(".minicartClose").click(function(){$("#minicart").hide();$(".my_cart").css('background-position','-373px -104px');});if(cart_item_count>3){$('#minicartjcarousel').jcarousel({vertical:true,scroll:3,size:cart_item_count,itemFallbackDimension:cart_height});}});$(document).ready(function(){$(".orderByPhone span").fancybox({helpers:{overlay:{opacity:0.5}},'type':'ajax','href':'/shop/faces/jsp/popup/cs_mbg_cod.html','maxWidth':800,'showCloseButton':true,'minWidth':500});});function Test(rad){var rads=document.getElementsByName(rad.name);document.getElementById('new_user').style.display=(rads[1].checked)?'none':'block';document.getElementById('existing_user').style.display=(rads[1].checked)?'block':'none';}
function boxOffHover(box){box.style.border='3px solid white';}
function boxOnHover(box){box.style.border='3px solid #57b6bd';}
$("#myForm\\:add1, #myForm\\:address1").bind('keypress keyup onkeydown',function(){var txtId=this.id;var txtArea=this.value;var len=txtArea.length;var MaxLen=250;if(len>MaxLen){this.value=txtArea.substring(0,MaxLen);$("#spanMaxCount").text(0);}else{$("#spanMaxCount").text((MaxLen-len));}});var timeractive=true;var $nextSelected=null;var $nextImgSelected=null;function slideSwitch(timer,difference){if(timeractive){var $active=$('#tab_style li.tab_selected');var $activeImg=$('#slideshow li.active');if($active.length==0)
$active=$('#slideshow li:last');if($activeImg.length==0)
$activeImg=$('#slideshow li:last');var $next=$nextSelected;if($nextSelected==null&&$nextImgSelected==null){$next=$active.next().length?$active.next():$('#tab_style li:first');$nextImg=$activeImg.next().length?$activeImg.next():$('#slideshow li:first');}else{$next=$nextSelected;$nextImg=$nextImgSelected;$nextSelected=null;$nextImgSelected=null;}
if($next[0]!=$active[0]){$active.addClass('tab_selected');$next.addClass('tab_selected').animate({opacity:1.0},timer,function(){$active.removeClass('tab_selected');});$activeImg.addClass('last-active');$nextImg.css({opacity:0.0}).addClass('active').animate({opacity:1.0},timer+difference,function(){$activeImg.removeClass('active last-active');});}}}
$(function(){setInterval("slideSwitch(100, 900)",5000);$hoverTab=$('#tab_style li a');$hoverTab.mouseover(function(event){var id=$(this).attr('id');$nextSelected=$('#tab_text'+id);$nextImgSelected=$('#image'+id);slideSwitch(10,0);timeractive=false;});$hoverTab.mouseout(function(event){timeractive=true;});$hoverImg=$('#slideshow li, .home_display_left_column map, .fluid3-2 map');$hoverImg.mouseover(function(event){var id=$('#slideshow li').attr('id');$nextSelected=$('#tab_text'+id);$nextImgSelected=$('#image'+id);slideSwitch(10,0);timeractive=false;});$hoverImg.mouseout(function(event){timeractive=true;});});$(document).ready(function(){$(".videoPopout a, .videoPdpPopout a").fancybox({'type':'ajax','transitionIn':'fade','transitionOut':'fade','speedIn':700,'speedOut':100,'overlayShow':true,'height':500,'width':700,'autoSize':false,'showCloseButton':true,'closeClick':true});$(".rogue").fancybox({helpers:{overlay:{opacity:0.5}},'type':'inline','maxWidth':800,'showCloseButton':true,'minWidth':500});});$(document).ready(function(){$("#q").autocomplete({minLength:2,source:function(request,response){request.categoryId=$("#q_category option:selected").val();if(self.xhr){self.xhr.abort();}
self.xhr=$.ajax({url:"/shop/faces/jsp/searchautosuggest.jsp",data:request,dataType:"json",success:function(data,status,xhr){if(xhr===self.xhr){response(data);}
self.xhr=null;},error:function(xhr){if(xhr===self.xhr){response([]);}
self.xhr=null;}});},focus:function(event,ui){$("#q").val(ui.item.value);return false;},select:function(event,ui){$("#q").val(ui.item.value);setAutosuggestCookie($("#q").val(),ui.item);$("#q_category option[value="
+ui.item.cid+"]").attr('selected','selected').trigger('change');goToSearch(ui.item.value,ui.item.type,ui.item.id);return false;}}).data("autocomplete")._renderMenu=(function(ul,items){var self=this,currentCategory="";$.each(items,function(index,item){if(item.category!=currentCategory){ul.append("<li class='ui-autocomplete-category span"
+item.cid
+"'>"
+item.category
+"</li>");currentCategory=item.category;}
renderHs18Item(ul,item);});});function renderHs18Item(ul,item){var thumbnail=item.thumbnail;var type=item.type;if(type=='title')
type='';if(thumbnail.substring(0,4)!='http'){thumbnail='http://stat.homeshop18.com/homeshop18'
+thumbnail;}
return $("<li></li>").data("item.autocomplete",item).append("<img style='float: left; margin: 5px 5px 5px 0px;width:25px;height:25px;' onerror='handleImgError(this)' src='"
+thumbnail+"'/>").append("<a style='color:#333;'>"+item.value
+"</a>").appendTo(ul);};});$(document).ready(function(){if(!$.browser.opera){$('select.category_box').each(function(){var title=$(this).attr('title');if($('option:selected',this).val()!='')
title=$('option:selected',this).text();$(this).css({'z-index':10,'opacity':0,'-khtml-appearance':'none'}).after('<span class="category_box"><span class="category_title">'
+title
+'</span><span class="category_select_down">&nbsp;</span></span>').change(function(){val=$('option:selected',this).text();$('.category_title').text(val);});});};});function go(){var _kwd=$('#q').val();if(!_kwd)
_kwd='';if((_kwd==$('#q').attr('alt'))||(_kwd=='')){return false;}
return goToSearch(_kwd,'');}
function goToSearch(query,type,id){var _searchURL;var _kwd=query;if(type=='title')
_kwd=id;var _domain=document.domain;var cid=$('#q_category').val();if(!_kwd)
_kwd='';_kwd=_kwd.replace(/^[ ]+/g,'').replace(/[ ]+$/g,'');if((_kwd==$('#qbooks').attr('alt'))||(_kwd=='')){return false;}
var _shop='';if(_domain.indexOf('homeshop18')==-1)
_shop="/shop";_kwd=_kwd.replace(':','`');_kwd=escape(_kwd);_searchURL=_shop+'/'+_kwd+'/search:'+_kwd;if(type!='null'&&type!='NULL'&&type!=''&&type!='undefined')
_searchURL=_searchURL+"/type:"+type;if(cid&&parseInt(cid,10)!='NaN'&&parseInt(cid,10)!='0')
_searchURL=_searchURL+"/categoryid:"+parseInt(cid,10);window.location.href=_searchURL;return false;}
function setAutosuggestCookie(query,item){var date=new Date();date.setTime(date.getTime()+(3*60*1000));var expires=" expires="+date.toGMTString();var jsonobj="{'query':'"+query+"','selectvalue':'"+item.value
+"','type':'"+item.type+"','cid':"+item.cid+"}";document.cookie="autosuggestcookie=\""+jsonobj+"\";"+expires+";"
+"path=/";return true;}
function newsLetterResponse(){var emailID=$("#emailIDSub").val();if(!EmailValidation(emailID)){return false;}
$.ajax({url:"/shop/faces/SubscriptionSrv",global:false,type:"POST",data:({emailID:emailID}),dataType:"html",success:function(msg){$('#responseDiv').text(msg);}});}
function EmailValidation(email){if(!validateXSS(email)){alert("Please enter a valid email address");document.getElementById("emailIDSub").focus();return false;}
var flagrate,flagdecimal,i,temp;for(i=0;i<email.length;i++){var temp=email.charAt(i);if(temp=="@")
flagrate="true";if(temp==".")
flagdecimal="true";}
if(flagrate!="true"||flagdecimal!="true"){alert("Please Enter valid EmailId");return false;}else{return true;}}
function validateXSS(input){var pattern=new RegExp("<|>|<\s*script.*?\s*>|javascript:","i");if(pattern.test(input)){return false;}else{return true;}}