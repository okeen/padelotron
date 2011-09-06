$(function() {
    window.Session = Backbone.Model.extend({
        defaults: {
            logged_facebook: true,
            logged_padelotron: false
        },

        initialize: function(){
            _.bindAll(this, 'session_changed', 'first_time_session', 'userLoggedIn',
                'checkNotifications', 'showNotifications', 'deleteNotification');
            if ($.cookie("_padelotron_tcg")== "1"){
                console.log("Found active Padelotron session cookie")
                this.set({
                    'logged_padelotron': true
                });
                this.deletedNotifications=[];
                this.checkNotifications();
            }
            $("#notifications_button").bind("click", this.showNotifications);
        },
        checkNotifications: function(){
            var notificationsCount= $("#player_has_notifications").val();
            if (notificationsCount > 0){
                console.debug("Session::Notif found: " +notificationsCount + " notifications" );
                $.when( $.ajax("/notifications.json")).then(function(data, status){
                    var unreadNotifications = _(data).select(function(notif){
                        return !notif.read;
                    });
                    if (unreadNotifications.length > 0){
                        console.debug("Session:Notif found unread notifs");
                        $("#notifications_button").addClass("with_notifications");
                    }
                    this.set({"notifications": data});
                    var urgentNotifications = _(unreadNotifications).select(function(notif){
                        return notif.params.urgent == true ;
                    });
                    for (var i=0; i<urgentNotifications.length; i++){
                        console.debug("Session::UrgentNotif found " +urgentNotifications[i].id);
                        $.gritter.add({
                            title: urgentNotifications[i].params.title,
                            class_name: "under_panel_notifications",
                            sticky: true,
                            before_close: _.throttle(this.deleteNotification,1000),
                            notificationId: urgentNotifications[i].id,
                            text: urgentNotifications[i].params.message
                        });
                    }
                    this.markNotificationsAsShown(urgentNotifications);
                }.bind(this));
            }
        },
        showNotifications: function(){
            var data = this.get("notifications");
            if (!data) return false;
            for (var i=0; i<data.length; i++){
                console.debug("Session::Notif " +data[i].id + " being shown" );
                $.gritter.add({
                    title: data[i].params.title,
                    class_name: "under_panel_notifications",
                    before_close: _.throttle(this.deleteNotification,1000),
                    notificationId: data[i].id,
                    text: data[i].params.message
                });
            }
            this.markNotificationsAsShown(data);
            $("#notifications_button").removeClass("with_notifications");
            return false;
        },
        markNotificationsAsShown: function(notifications){
            for (var i=0; i<notifications.length; i++){
                var d= notifications[i];
                if (d.read)
                    continue;
                console.debug("Session::Notif " +d.id + " to be marked READ" );
                $.ajax({
                    url: "/notifications/" + d.id + ".json",
                    type: "PUT",
                    data: {
                        notification: {
                            read: true
                        }
                    },
                    success: function(){
                        d.read = true;
                        console.debug("Session::Notif " +d.id + " mrked as read" );
                    }
                })
            }
        },
        deleteNotification: function(e, manualClose){
            var nId = e.data("notificationId");
            if (!manualClose || _(this.deletedNotifications).include(nId))
                return false;
            console.debug("Session:Notif deleting notification#" + nId);
            $.ajax({
                url: "/notifications/" + nId + ".json",
                type: "DELETE",
                success: function(){
                    this.deletedNotifications.push(nId);
                    console.debug("Session:Notif deleted notification#" + nId);
                }
            });
        },
        session_changed: function(session_data){
            var status = session_data.status;
            console.log("FB::session new status: "+status);
            if (status == "notConnected") {
                this.set({
                    'logged_facebook': false
                });
                return;
            }
            if (this.get('logged_facebook') && this.get('logged_padelotron')) {
                console.log("Already logged in FB, ignoring");
                return;
            }
            this.set({
                'logged_facebook': session_data.status == "connected"
            });
            $.ajax({
                url: "/player_session/facebook/login",
                type: 'POST',
                data: {
                    facebook_access_token: session_data.session.access_token
                },
                success:this.userLoggedIn
            });
        },
        userLoggedIn: function(response, status){
            console.log("Session::Padelotron logged in for user: ");
            if (this.get("newPlayer") == true){
                console.debug("Session New player detected, redirecting to player's home");
                window.location.href= window.location.protocol + "//" +
                window.location.host + "/home";
                return;
            }
            this.set({
                'logged_padelotron': true
            });
            $("#player_session_panel").replaceWith(response);
            this.checkNotifications();
        },
        first_time_session: function(session_data){
            console.debug("Session::Facebook first time session");
            this.set({
                'newPlayer': true
            });
        }
    });

    window.User = Backbone.Model.extend({

        });
    window.SessionView = Backbone.View.extend({
        id: "user_panel",
        initialize: function(){
            _.bindAll(this, 'render', 'openUserLocationPanel');
            this.model.bind('change', this.render);
            $("#ask_user_location").live("click", this.openUserLocationPanel);
        },
        openUserLocationPanel: function(e){
            $.dialog("")
        },
        render: function(){
            if (this.model.get('logged')) {
                $(this.el).hide();
            } else {
                $(this.el).show();
            }
        }
    });
    window.session = new Session();
    window.session_view = new SessionView({
        model: window.session
    });


    window.fbAsyncInit = function() {
        FB.init({
            appId: window._facebook_app_id,
            status: true,
            cookie: true,
            xfbml: true
        });
        FB.Event.subscribe('auth.sessionChange', window.session.session_changed);
        FB.Event.subscribe('auth.login', window.session.first_time_session);
        FB.Event.subscribe('auth.statusChange', function(response) {
            //alert("Status: " + response.status);
            });
        FB.getLoginStatus(function(response) {
            if (response.session) {
                window.session.session_changed(response)
            } else {
        // no user session available, someone you dont know
        }
        });

    };

    $('body').append('<div id="fb-root"></div>');

    $.getScript(document.location.protocol + '//static.ak.fbcdn.net/connect/en_US/core.debug.js');
})