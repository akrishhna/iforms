/*
 *
 * Copyright (c) 2010 C. F., Wong (<a href="http://cloudgen.w0ng.hk">Cloudgen Examplet Store</a>)
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */
/*
 *
 * Copyright (c) 2011 Cloudgen Wong (<a href="http://www.cloudgen.w0ng.hk">Cloudgen Wong</a>)
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */
/*
 * PLUGIN URL : http://www.examplet.buss.hk/jquery/format.php
 */
// version 1.05 
// fix the problem of jQuery 1.5 when using .val() 
// fix the problem when precision has been set and the input start with decimal dot or comma ,e.g. precision set to 3 and input with ".1234"
var email={tldn:new RegExp("^[^\@]+\@[^\@]+\.(A[C-GL-OQ-UWXZ]|B[ABD-JM-OR-TVWYZ]|C[ACDF-IK-ORUVX-Z]|D[EJKMOZ]|E[CEGR-U]|F[I-KMOR]|G[ABD-IL-NP-UWY]|H[KMNRTU]|I[DEL-OQ-T]|J[EMOP]|K[EG-IMNPRWYZ]|L[A-CIKR-VY]|M[AC-EGHK-Z]|N[ACE-GILOPRUZ]|OM|P[AE-HKL-NR-TWY]|QA|R[EOSUW]|S[A-EG-ORT-VYZ]|T[CDF-HJ-PRTVWZ]|U[AGKMSYZ]|V[ACEGINU]|W[FS]|XN|Y[ETU]|Z[AMW]|AERO|ARPA|ASIA|BIZ|CAT|COM|COOP|EDU|GOV|INFO|INT|JOBS|MIL|MOBI|MUSEUM|NAME|NET|ORG|PRO|TEL|TRAVEL)$","i")};
(function($){
  $.extend($.expr[":"],{
    regex:function(d,a,c){
      var e=new RegExp(c[3],"g");
      var b=("text"===d.type)?d.value:d.innerHTML;
      return(b=="")?true:(e.exec(b))
    }
  });
  $.fn.output=function(d){
    if(typeof d=="undefined")
      return (this.is(":text"))?this.val():this.html();
    else
      return (this.is(":text"))?this.val(d):this.html(d);
  };
  formatter={
    getRegex:function(settings){
      var settings=$.extend({type:"decimal",precision:5,decimal:'.',allow_negative:true},settings);
      var result="";
      if(settings.type=="decimal"){
        var e=(settings.allow_negative)?"-?":"";
        if(settings.precision>0)
          result="^"+e+"\\d+$|^"+e+"\\d*"+settings.decimal+"\\d{1,"+settings.precision+"}$";
        else result="^"+e+"\\d+$"
      }else if(settings.type=="phone-number"){
        result="^\\d[\\d\\-]*\\d$"
      }else if(settings.type=="alphabet"){
        result="^[A-Za-z]+$"
      }
      return result
    },
    isEmail:function(d){
      var a=$(d).output();
      var c=false;
      var e=true;
      var e=new RegExp("[\s\~\!\#\$\%\^\&\*\+\=\(\)\[\]\{\}\<\>\\\/\;\:\,\?\|]+");
      if(a.match(e)!=null){
        return c
      }
      if(a.match(/((\.\.)|(\.\-)|(\.\@)|(\-\.)|(\-\-)|(\-\@)|(\@\.)|(\@\-)|(\@\@))+/)!=null){
        return c
      }
      if(a.indexOf("\'")!=-1){
        return c
      }
      if(a.indexOf("\"")!=-1){
        return c
      }
      if(email.tldn&&a.match(email.tldn)==null){
        return c
      }
      return e
    },
    formatString:function(target,settings){
      var settings=$.extend({type:"decimal",precision:5,decimal:'.',allow_negative:true},settings);
      var oldText=$(target).output();
      var newText=oldText;
      if(settings.type=="decimal"){
        if(newText!=""){
          var g;
          var h=(settings.allow_negative)?"\\-":"";
          var i="\\"+settings.decimal;
          g=new RegExp("[^\\d"+h+i+"]+","g");
          newText=newText.replace(g,"");
          var h=(settings.allow_negative)?"\\-?":"";
          if(settings.precision>0)
            g=new RegExp("^("+h+"\\d*"+i+"\\d{1,"+settings.precision+"}).*");
          else g=new RegExp("^("+h+"\\d+).*");
          newText=newText.replace(g,"$1")
        }
      }else if(settings.type=="phone-number"){
        newText=newText.replace(/[^\-\d]+/g,"").replace(/^\-+/,"").replace(/\-+/,"-")
      }else if(settings.type=="alphabet"){
        newText=newText.replace(/[^A-Za-z]+/g,"")
      }
      if(newText!=oldText)
        $(target).output(newText)
    }
  };
  $.fn.format=function(settings,wrongFormatHandler){
    var settings=$.extend({type:"decimal",precision:5,decimal:".",allow_negative:true,autofix:false},settings);
    var decimal=settings.decimal;
    wrongFormatHandler=typeof wrongFormatHandler=="function"?wrongFormatHandler:function(){};
    this.keypress(function(d){
      $(this).data("old-value",$(this).val());
      var a=d.charCode?d.charCode:d.keyCode?d.keyCode:0;
      if(a==13&&this.nodeName.toLowerCase()!="input"){return false}
      if((d.ctrlKey&&(a==97||a==65||a==120||a==88||a==99||a==67||a==122||a==90||a==118||a==86||a==45))||(a==46&&d.which!=null&&d.which==0))
        return true;
      if(a<48||a>57){
        if(settings.type=="decimal"){
          if(settings.allow_negative&&a==45&&this.value.length==0)return true;
          if(a==decimal.charCodeAt(0)){
            if(settings.precision>0&&this.value.indexOf(decimal)==-1)return true;
            else return false
          }
          if(a!=8&&a!=9&&a!=13&&a!=35&&a!=36&&a!=37&&a!=39){return false}
          return true
        }else if(settings.type=="email"){
          if(a==8||a==9||a==13||(a>34&&a<38)||a==39||a==45||a==46||(a>64&&a<91)||(a>96&&a<123)||a==95){return true}
          if(a==64&&this.value.indexOf("@")==-1)return true;
          return false
        }else if(settings.type=="phone-number"){
          if(a==45&&this.value.length==0)return false;
          if(a==8||a==9||a==13||(a>34&&a<38)||a==39||a==45){return true}
          return false
        }else if(settings.type=="alphabet"){
          if(a==8||a==9||a==13||(a>34&&a<38)||a==39||(a>64&&a<91)||(a>96&&a<123))
          return true
        }else return false
      }else{
        if(settings.type=="alphabet"){
          return false
        }else return true
      }
    })
    .blur(function(){
      if(settings.type=="email"){
        if(!formatter.isEmail(this)){
          wrongFormatHandler.apply(this)
        }
      }else{
        if(!$(this).is(":regex("+formatter.getRegex(settings)+")")){
          wrongFormatHandler.apply(this)
        }
      }
    })
    .focus(function(){
      $(this).select()
    });
    if(settings.autofix){
      this.keyup(function(d){
        if($(this).data("old-value")!=$(this).val())
          formatter.formatString(this,settings)
        }
      )
    }
    return this
  }
})(jQuery);