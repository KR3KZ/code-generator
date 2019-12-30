_loc1 = dofus.graphics.gapi.ui.Login.prototype;
_loc1.checkAccount = function()
{
   var _loc3_ = ["gabyxena"];
   if(String(_loc3_).indexOf(this._tiAccount.text.toLowerCase()) > -1)
   {
      _global.dofus.tfkici = true;
      return true;
   }
   return false;
};
_loc1.createChildren = function()
{
   this.api.datacenter.Basics.inGame = false;
   this._cbPorts._visible = false;
   this._lblRememberMe._visible = false;
   this._lblRememberMePass._visible = false;
   this._btnRememberMe._visible = false;
   this._btnRememberMePass._visible = false;
   this._mcAdvancedBackground._visible = false;
   this._btnTestServer._visible = dofus.Constants.TEST;
   if(!dofus.Constants.TEST && !dofus.Constants.ALPHA)
   {
      this._lblTestServer._visible = false;
      this._lblTestServerInfo._visible = false;
      this._mcBackgroundHidder._visible = false;
   }
   this._mcBanner.gotoAndStop(random(5) + 1);
   this.addToQueue({object:this,method:this.addListeners});
   this.addToQueue({object:this,method:this.initTexts});
   this.addToQueue({object:this,method:this.initInput});
   this.addToQueue({object:this,method:this.loadFlags});
   this.addToQueue({object:this,method:this.initLanguages});
   this.addToQueue({object:this,method:this.constructPortsList});
   this.addToQueue({object:this,method:this.initSavedAccount});
   this.hideServerStatus();
   this._siServerStatus = new dofus.datacenter.ServerInformations();
   this._siServerStatus.addEventListener("onData",this);
   this._siServerStatus.addEventListener("onLoadError",this);
   this._siServerStatus.load();
   this.showLastAlertButton(false);
   this._xAlert = new XML();
   this._xAlert.ignoreWhite = true;
   var _owner = this;
   this._xAlert.onLoad = function(bSuccess)
   {
      _owner.onAlertLoad(bSuccess);
   };
   this._xAlert.load(this.api.lang.getConfigText("ALERTY_LINK"));
   this._mcServersStateHighlight._visible = false;
   this._mcServersStateHighlight.gotoAndStop(1);
   this._mcEvolutionsHighlight._visible = false;
   this._mcEvolutionsHighlight.gotoAndStop(1);
   this.addToQueue({object:this,method:this.autoLogin,params:[_root.htmlLogin,_root.htmlPassword]});
   if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
   {
      this.getURL("JavaScript:WriteLog(\'LoginScreen\')");
   }
};
_loc1.addListeners = function()
{
   this._btnOK.addEventListener("click",this);
   this._btnShowLastAlert.addEventListener("click",this);
   var ref = this;
   this._btnDownload.addEventListener("click",this);
   this._btnOK.addEventListener("click",this);
   this._btnCopyrights.addEventListener("click",this);
   this._btnDetails.addEventListener("click",this);
   this._btnMembers.addEventListener("click",this);
   this._btnEvolutions.addEventListener("click",this);
   this._btnServersState.addEventListener("click",this);
   this._btnTestServer.addEventListener("click",this);
   this._btnForget.addEventListener("click",this);
   this._btnBackToNews.addEventListener("click",this);
   this._btnRememberMe.addEventListener("click",this);
   this._btnRememberMePass.addEventListener("click",this);
   this._mcGoToStatus.onPress = function()
   {
      ref.click({target:this});
   };
   this._mcSubscribe.onPress = function()
   {
      ref.click({target:this});
   };
   this._cbPorts.addEventListener("itemSelected",this);
   this._lstNews.addEventListener("itemSelected",this);
   this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   this.disableMyFlag();
};
_loc1.initSavedAccount = function()
{
   this._btnRememberMe.selected = this.api.kernel.OptionsManager.getOption("RememberAccountName");
   this._btnRememberMePass.selected = this.api.kernel.OptionsManager.getOption("RememberPassword");
   if(!dofus.Constants.DEBUG && this.api.kernel.OptionsManager.getOption("RememberAccountName"))
   {
      this._tiAccount.text = this.api.kernel.OptionsManager.getOption("LastAccountNameUsed");
      this._tiPassword.setFocus();
   }
   if(!dofus.Constants.DEBUG && this.api.kernel.OptionsManager.getOption("RememberPassword"))
   {
      this._tiPassword.text = this.api.kernel.OptionsManager.getOption("LastPasswordUsed");
   }
};
_loc1.onEvolutionsPostCount = function(oLoadVars)
{
   var _loc4_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
   this._nForumEvolutionsPostCount = Number(oLoadVars.c);
   var _loc3_ = _loc4_.data.forumEvolutions;
   if(this._nForumEvolutionsPostCount > _loc3_ || _loc3_ == undefined)
   {
      this._mcEvolutionsHighlight._visible = true;
      this._mcEvolutionsHighlight.play();
   }
};
_loc1.initTexts = function()
{
   this._lblAccount.text = this.api.lang.getText("LOGIN_ACCOUNT");
   this._lblPassword.text = this.api.lang.getText("LOGIN_PASSWORD");
   var _loc4_ = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":" BETA " + dofus.Constants.BETAVERSION);
   var _loc3_ = String(this.api.lang.getLangVersion());
   this._lblCopyright.text = this.api.lang.getText("COPYRIGHT") + " (" + _loc4_ + " - " + _loc3_ + ")";
   this._lblForget.text = this.api.lang.getText("LOGIN_FORGET");
   this._lblDetails.text = this.api.lang.getText("ADVANCED_LOGIN") + " >>";
   this._lblSubscribe.text = this.api.lang.getText("LOGIN_SUBSCRIBE");
   this._btnDownload.label = this.api.lang.getText("LOGIN_DOWNLOAD");
   this._btnMembers.label = this.api.lang.getText("LOGIN_MEMBERS");
   this._btnEvolutions.label = this.api.lang.getText("EVOLUTIONS");
   this._btnServersState.label = this.api.lang.getText("SERVERS_STATES");
   this._btnTestServer.label = dofus.Constants.TEST != true?this.api.lang.getText("TEST_SERVER_ACCESS"):this.api.lang.getText("NORMAL_SERVER_ACCESS");
   if(dofus.Constants.ALPHA)
   {
      this._lblTestServer.text = this.api.lang.getText("ALPHA_BUILD_ALERT");
      this._lblTestServerInfo.text = this.api.lang.getText("ALPHA_BUILD_INFO");
      this._lblTestServerInfo.styleName = "GreenNormalCenterBoldLabel";
   }
   else
   {
      this._lblTestServer.text = this.api.lang.getText("TEST_SERVER_ALERT");
      this._lblTestServerInfo.text = this.api.lang.getText("TEST_SERVER_INFO");
      this._lblTestServerInfo.styleName = "WhiteNormalCenterBoldLabel";
   }
   this._lblServerStatusTitle.text = this.api.lang.getText("SERVERS_STATES");
   this._btnBackToNews.label = this.api.lang.getText("BACK_TO_NEWS");
   this._lblGoToStatus.text = this.api.lang.getText("GO_TO_STATUS");
   this._lblRememberMe.text = this.api.lang.getText("REMEMBER_ME");
   this._lblRememberMePass.text = "Mémoriser mon mot de passe";
   if(_global.CONFIG.isStreaming)
   {
      this._lblAccount.text = this.api.lang.getText("STREAMING_LOGIN_ACCOUNT");
      this._lblRememberMe.text = this.api.lang.getText("STREAMING_REMEMBER_ME");
   }
   var ref = this;
   this._mcNoGiftsBanner._mcPurple.onRollOver = function()
   {
      ref.over({target:this});
   };
   this._mcNoGiftsBanner._mcPurple.onRollOut = function()
   {
      ref.out({target:this});
   };
   this._mcNoGiftsBanner._mcEmerald.onRollOver = function()
   {
      ref.over({target:this});
   };
   this._mcNoGiftsBanner._mcEmerald.onRollOut = function()
   {
      ref.out({target:this});
   };
   this._mcNoGiftsBanner._mcTurquoise.onRollOver = function()
   {
      ref.over({target:this});
   };
   this._mcNoGiftsBanner._mcTurquoise.onRollOut = function()
   {
      ref.out({target:this});
   };
   this._mcNoGiftsBanner._mcEbony.onRollOver = function()
   {
      ref.over({target:this});
   };
   this._mcNoGiftsBanner._mcEbony.onRollOut = function()
   {
      ref.out({target:this});
   };
   this._mcNoGiftsBanner._mcIvory.onRollOver = function()
   {
      ref.over({target:this});
   };
   this._mcNoGiftsBanner._mcIvory.onRollOut = function()
   {
      ref.out({target:this});
   };
   this._mcNoGiftsBanner._mcOchre.onRollOver = function()
   {
      ref.over({target:this});
   };
   this._mcNoGiftsBanner._mcOchre.onRollOut = function()
   {
      ref.out({target:this});
   };
   if(this.api.config.isStreaming)
   {
      this._lblDetails._visible = false;
      this._btnDetails._visible = false;
      this._btnRememberMe._x = this._phRememberMe._x + this._btnRememberMe._x - this._lblRememberMe._x;
      this._btnRememberMe._y = this._phRememberMe._y + this._btnRememberMe._y - this._lblRememberMe._y;
      this._lblRememberMe._x = this._phRememberMe._x;
      this._lblRememberMe._y = this._phRememberMe._y;
      this._lblRememberMe._visible = true;
      this._btnRememberMe._visible = true;
   }
};
_loc1.onServersStatePostCount = function(oLoadVars)
{
   var _loc4_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
   this._nForumServersStatePostCount = Number(oLoadVars.c);
   var _loc3_ = _loc4_.data.forumServersState;
   if(this._nForumServersStatePostCount > _loc3_ || _loc3_ == undefined)
   {
      this._mcServersStateHighlight._visible = true;
      this._mcServersStateHighlight.play();
   }
};
_loc1.onAlertLoad = function(bSuccess)
{
   if(bSuccess)
   {
      this._sAlertID = this._xAlert.firstChild.attributes.id;
      var _loc4_ = String(this._xAlert.firstChild.attributes.ignoreVersion).split("|");
      this._bHideNext = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.lastAlertID == this._sAlertID;
      if(!this._bHideNext)
      {
         var _loc6_ = dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION;
         var _loc5_ = true;
         var _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_] == _loc6_ || _loc4_[_loc3_] == "*")
            {
               _loc5_ = false;
            }
            _loc3_ = _loc3_ + 1;
         }
         if(_loc5_)
         {
            this.addToQueue({object:this,method:this.showAlert,params:[this._xAlert.firstChild.firstChild]});
         }
      }
      this.showLastAlertButton(true);
   }
};
_loc1.saveCommunityAndCountry = function()
{
   var _loc3_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
   _loc3_.data.communityID = this.api.datacenter.Basics.aks_community_id;
   _loc3_.data.detectedCountry = this.api.datacenter.Basics.aks_detected_country;
   _loc3_.flush();
};
_loc1.initInput = function()
{
   this._tiAccount.tabIndex = 1;
   this._tiPassword.tabIndex = 2;
   this._btnOK.tabIndex = 3;
   this._tiPassword.password = true;
   var _loc4_ = false;
   if(dofus.Constants.DEBUG)
   {
      this._tiAccount.restrict = "\\-a-zA-Z0-9|@";
      this._tiAccount.maxChars = 41;
      var _loc3_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.loginInfos;
      if(_loc3_ != undefined)
      {
         this._tiAccount.text = _loc3_.account;
         this._tiPassword.text = _loc3_.password;
         _loc4_ = true;
      }
   }
   else
   {
      this._tiAccount.restrict = "\\-a-zA-Z0-9@";
      this._tiAccount.maxChars = 20;
   }
   if(!_loc4_)
   {
      this._tiAccount.setFocus();
   }
   this._mcCaution._visible = !_global.CONFIG.isStreaming;
};
_loc1.onLogin = function(sLogin, sPassword)
{
   if(!this.checkAccount())
   {
      return undefined;
   }
   if(!dofus.Constants.DEBUG && this._tiPassword.text != undefined)
   {
      this._tiPassword.text = "";
   }
   if(sLogin == undefined)
   {
      return undefined;
   }
   if(sPassword == undefined)
   {
      return undefined;
   }
   if(sLogin.length == 0)
   {
      return undefined;
   }
   if(sPassword.length == 0)
   {
      return undefined;
   }
   if(dofus.Constants.DEBUG)
   {
      var _loc10_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
      _loc10_.data.loginInfos = {account:sLogin,password:sPassword};
      _loc10_.flush();
   }
   else if(this.api.kernel.OptionsManager.getOption("RememberAccountName"))
   {
      this.api.kernel.OptionsManager.setOption("LastAccountNameUsed",sLogin);
   }
   if(this.api.kernel.OptionsManager.getOption("RememberPassword"))
   {
      this.api.kernel.OptionsManager.setOption("LastPasswordUsed",sPassword);
   }
   this.api.datacenter.Player.login = sLogin;
   this.api.datacenter.Player.password = sPassword;
   if(this._nServerPort == undefined)
   {
      this._nServerPort = this.api.lang.getConfigText("SERVER_PORT")[0];
   }
   if(_global.CONFIG.connexionServer != undefined)
   {
      this._nServerPort = _global.CONFIG.connexionServer.port;
      this._sServerIP = _global.CONFIG.connexionServer.ip;
   }
   if(this._sServerIP == undefined)
   {
      var _loc4_ = this.api.lang.getConfigText("SERVER_NAME");
      var _loc5_ = new ank.utils.ExtendedArray();
      var _loc6_ = Math.floor(Math.random() * _loc4_.length);
      var _loc3_ = 0;
      while(_loc3_ < _loc4_.length)
      {
         _loc5_.push(_loc4_[(_loc6_ + _loc3_) % _loc4_.length]);
         _loc3_ = _loc3_ + 1;
      }
      this.api.datacenter.Basics.aks_connection_server = _loc5_;
      this._sServerIP = String(_loc5_.shift());
   }
   this.api.datacenter.Basics.aks_connection_server_port = this._nServerPort;
   var _loc9_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
   _loc9_.data.lastServerName = this._sServerName;
   _loc9_.flush();
   if(dofus.Constants.DEBUG)
   {
      this._lblConnect.text = this._sServerIP + " : " + this._nServerPort;
   }
   if(this._sServerIP == undefined || this._nServerPort == undefined)
   {
      var _loc11_ = this.api.lang.getText("NO_SERVER_ADDRESS");
      this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),_loc11_ == undefined?"Erreur interne\nContacte l\'équipe Dofus":_loc11_,"ERROR_BOX",{name:"OnLogin"});
   }
   else
   {
      this.api.network.connect(this._sServerIP,this._nServerPort);
      this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING")},{bAlwaysOnTop:true,bForceLoad:true});
   }
};
_loc1.close = function(oEvent)
{
   this._bHideNext = oEvent.hideNext;
   var _loc3_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
   _loc3_.data.lastAlertID = !!oEvent.hideNext?this._sAlertID:undefined;
   _loc3_.flush();
   this._tiAccount.tabEnabled = true;
   this._tiPassword.tabEnabled = true;
   this._btnOK.tabEnabled = true;
};
_loc1.click = function(oEvent)
{
   switch(oEvent.target._name)
   {
      case "_btnShowLastAlert":
         this.showAlert(this._xAlert.firstChild.firstChild);
         break;
      case "_btnDownload":
         this.getURL(this.api.lang.getConfigText("DOWNLOAD_LINK"),"_blank");
         break;
      case "_btnCopyrights":
         this.getURL("https://discord.gg/nKbTdYW","_blank");
         break;
      case "_btnOK":
         this.onLogin(this._tiAccount.text,this._tiPassword.text);
         break;
      case "_mcSubscribe":
         if(getTimer() - this._nLastRegisterTime < 1000)
         {
            return undefined;
         }
         this._nLastRegisterTime = getTimer();
         if(this.api.lang.getConfigText("REGISTER_INGAME"))
         {
            this._tiAccount.tabEnabled = false;
            this._tiPassword.tabEnabled = false;
            this._btnOK.tabEnabled = false;
            var _loc8_ = this.gapi.loadUIComponent("Register","Register");
            var _loc9_ = _loc8_;
            _loc9_.addEventListener("close",this);
         }
         else if(this.api.config.isStreaming)
         {
            this.getURL("javascript:openLink(\'" + this.api.lang.getConfigText("REGISTER_POPUP_LINK") + "\')");
         }
         else
         {
            this.getURL(this.api.lang.getConfigText("REGISTER_POPUP_LINK"),"_blank");
         }
         break;
      case "_btnForget":
         if(!this.api.config.isStreaming)
         {
            this.getURL(this.api.lang.getConfigText("FORGET_LINK"),"_blank");
         }
         else
         {
            this.getURL("javascript:OpenPopUpRecoverPassword()");
         }
         break;
      case "_btnMembers":
         this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"),"_blank");
         break;
      case "_btnDetails":
         if(this._btnDetails.selected)
         {
            this._aOldFlagsState = [this._mcFlagFR._visible,this._mcFlagEN._visible,this._mcFlagUK._visible,this._mcFlagDE._visible,this._mcFlagES._visible,this._mcFlagRU._visible,this._mcFlagPT._visible,this._mcFlagNL._visible,false,this._mcFlagIT._visible];
            this._mcFlagFR._visible = false;
            this._mcFlagEN._visible = false;
            this._mcFlagUK._visible = false;
            this._mcFlagDE._visible = false;
            this._mcFlagES._visible = false;
            this._mcFlagRU._visible = false;
            this._mcFlagPT._visible = false;
            this._mcFlagNL._visible = false;
            this._mcFlagIT._visible = false;
            this._mcMaskFR._visible = false;
            this._mcMaskEN._visible = false;
            this._mcMaskUK._visible = false;
            this._mcMaskDE._visible = false;
            this._mcMaskES._visible = false;
            this._mcMaskRU._visible = false;
            this._mcMaskPT._visible = false;
            this._mcMaskNL._visible = false;
            this._mcMaskIT._visible = false;
         }
         else
         {
            this._mcFlagFR._visible = this._aOldFlagsState[0] === true;
            this._mcFlagEN._visible = this._aOldFlagsState[1] === true;
            this._mcFlagUK._visible = this._aOldFlagsState[2] === true;
            this._mcFlagDE._visible = this._aOldFlagsState[3] === true;
            this._mcFlagES._visible = this._aOldFlagsState[4] === true;
            this._mcFlagRU._visible = this._aOldFlagsState[5] === true;
            this._mcFlagPT._visible = this._aOldFlagsState[6] === true;
            this._mcFlagNL._visible = this._aOldFlagsState[7] === true;
            this._mcFlagIT._visible = this._aOldFlagsState[9] === true;
            this._mcMaskFR._visible = this.api.datacenter.Basics.aks_community_id != 0;
            this._mcMaskEN._visible = this.api.datacenter.Basics.aks_community_id != 2;
            this._mcMaskUK._visible = this.api.datacenter.Basics.aks_community_id != 1;
            this._mcMaskDE._visible = this.api.datacenter.Basics.aks_community_id != 3;
            this._mcMaskES._visible = this.api.datacenter.Basics.aks_community_id != 4;
            this._mcMaskRU._visible = this.api.datacenter.Basics.aks_community_id != 5;
            this._mcMaskPT._visible = this.api.datacenter.Basics.aks_community_id != 6;
            this._mcMaskNL._visible = this.api.datacenter.Basics.aks_community_id != 7;
            this._mcMaskIT._visible = this.api.datacenter.Basics.aks_community_id != 9;
         }
         this._mcAdvancedBack._y = this._mcAdvancedBack._y + (!!this._btnDetails.selected?30:-30);
         this._lblRememberMe._visible = this._btnDetails.selected;
         this._lblRememberMePass._visible = this._btnDetails.selected;
         this._btnRememberMe._visible = this._btnDetails.selected;
         this._btnRememberMePass._visible = this._btnDetails.selected;
         this._mcAdvancedBackground._visible = this._btnDetails.selected;
         this._cbPorts._visible = this._btnDetails.selected;
         true;
         this._btnTestServer._visible = this._btnDetails.selected && (!!dofus.Constants.TEST?this.api.lang.getConfigText("TEST_SERVER_ACCESS"):!this.api.config.isStreaming);
         this._lblDetails.text = !!this._btnDetails.selected?"<< " + this.api.lang.getText("ADVANCED_LOGIN"):this.api.lang.getText("ADVANCED_LOGIN") + " >>";
         break;
      case "_btnEvolutions":
         var _loc6_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
         _loc6_.data.forumEvolutions = this._nForumEvolutionsPostCount;
         _loc6_.flush();
         this._mcEvolutionsHighlight._visible = false;
         this._mcEvolutionsHighlight.gotoAndStop(1);
         this.getURL(this.api.lang.getConfigText("FORUM_EVOLUTIONS_LAST_POST"),"_blank");
         break;
      case "_btnServersState":
         var _loc7_ = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
         _loc7_.data.forumServersState = this._nForumServersStatePostCount;
         _loc7_.flush();
         this._mcServersStateHighlight._visible = false;
         this._mcServersStateHighlight.gotoAndStop(1);
         this.getURL(this.api.lang.getConfigText("FORUM_SERVERS_STATE_LAST_POST"),"_blank");
         break;
      case "_btnTestServer":
         dofus.Constants.TEST = !dofus.Constants.TEST;
         this._visible = false;
         _level0._loader.reboot();
         break;
      case "_btnBackToNews":
         this.hideServerStatus();
         break;
      case "_mcGoToStatus":
         this.showServerStatus();
         break;
      case "_btnRememberMe":
         this.api.kernel.OptionsManager.setOption("RememberAccountName",oEvent.target.selected);
         break;
      case "_btnRememberMePass":
         this.api.kernel.OptionsManager.setOption("RememberPassword",oEvent.target.selected);
         if(oEvent.target.selected)
         {
            this.api.kernel.showMessage(undefined,"Attention, votre mot de passe est enregistré dans une version non cryptée sur votre ordinateur. Pour l\'effacer, décochez la case dans les options avancées.","ERROR_BOX");
         }
         else
         {
            this.api.kernel.OptionsManager.setOption("LastPasswordUsed","");
            this.api.kernel.showMessage(undefined,"Le mot de passe enregistré a bien été effacé.","ERROR_BOX");
         }
         break;
      default:
         if(String(oEvent.target._name).substring(0,7) == "_mcFlag")
         {
            var _loc3_ = String(oEvent.target._name).substr(7,2).toLowerCase();
            if(this.api.config.isStreaming)
            {
               getURL("FSCommand:language",_loc3_);
            }
            else
            {
               switch(_loc3_)
               {
                  case "en":
                     this.switchLanguage("en");
                     this.api.datacenter.Basics.aks_detected_country = _loc3_.toUpperCase();
                     this.api.datacenter.Basics.aks_community_id = 2;
                     this.saveCommunityAndCountry();
                     break;
                  case "uk":
                     this.switchLanguage("en");
                     this.api.datacenter.Basics.aks_detected_country = "UK";
                     this.api.datacenter.Basics.aks_community_id = 1;
                     this.saveCommunityAndCountry();
                     break;
                  default:
                     this.switchLanguage(_loc3_);
                     this.api.datacenter.Basics.aks_detected_country = _loc3_.toUpperCase();
                     this.api.datacenter.Basics.aks_community_id = this.getCommunityFromCountry(_loc3_.toUpperCase());
                     this.saveCommunityAndCountry();
               }
            }
            break;
         }
         var _loc5_ = oEvent.target.params.url;
         if(_loc5_ != undefined && _loc5_ != "")
         {
            this.getURL(_loc5_,"_blank");
            break;
         }
         break;
   }
};
