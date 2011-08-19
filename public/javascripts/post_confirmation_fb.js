$(function() {
    window.ConfirmedModel = Backbone.Model.extend({
        defaults: {
            
        },

        initialize: function(){
            
        }
        
    });

    window.ConfirmedModelView = Backbone.View.extend({
        el: "#confirmed_model_panel",
        
        initialize: function(){
            _.bindAll(this, 'render','postConfirmationInFacebook');
            var model = new ConfirmedModel({
                confirmable_type: $(this.el).find("input[name='model_confirmable_type']")[0].value,
                confirmable_id: $(this.el).find("input[name='model_confirmable_id']")[0].value,
                confirmation_message: $(this.el).find("input[name='model_confirmation_message']")[0].value
            });
            this.model = model;
            console.debug("NewModel found: " +model.get("confirmable_type") + "#" + model.get("confirmable_id"));
            $('button.post_to_facebook').live('click', this.postConfirmationInFacebook);
        },
        render: function(){
            return this;
        },
        postConfirmationInFacebook: function(){

            var url = window.location.protocol + "//" + window.location.host;
            url += "/" + this.model.get('confirmable_type').toLowerCase() +"/"+this.model.get('confirmable_id');
            console.debug("FB:Feed panel for " +url);
            var msg = this.model.get("confirmation_message");
            //_.bind('save_game_facebook_request_id', this);
            FB.ui({
                method: 'feed',
                //to: game.player2.facebook_id,
                link: url,
                caption: msg,
                description: 'tracking information for the user'
            },function(response){
                alert(response);
            });
        }
    });
    window.confirmedModelView = new ConfirmedModelView();
})