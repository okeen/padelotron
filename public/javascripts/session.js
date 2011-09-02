$(function() {
    window.Session = Backbone.Model.extend({
        defaults: {
            logged_facebook: true,
            logged_padelotron: false
        },

        initialize: function(){
            _.bindAll(this, 'session_changed', 'first_time_session', 'userLoggedIn');
            if ($.cookie("_padelotron_tcg")== "1"){
                console.log("Found active Padelotron session cookie")
                this.set({
                    'logged_padelotron': true
                });
            }
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
                data: {facebook_access_token: session_data.session.access_token},
                success:this.userLoggedIn});
        },
        userLoggedIn: function(response, status){
            console.log("Padelotron::session logged in for user: ");
            if (this.redirectToPlayerHomeAfterLogin){
                 window.location.href= window.location.protocol + "//" +
                        window.location.host + "/home";
                return;
            }
            this.set({'logged_padelotron': true});
            $("#player_session_panel").replaceWith(response);
        },
        first_time_session: function(session_data){
            //New user on site, notify it
            this.redirectToPlayerHomeAfterLogin = true;
        }
    });

    window.User = Backbone.Model.extend({

        });
    window.SessionView = Backbone.View.extend({
        id: "user_panel",
        initialize: function(){
            _.bindAll(this, 'render');
            this.model.bind('change', this.render);
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