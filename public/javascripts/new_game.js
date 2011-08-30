$(function() {
    window.NewGame = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
            _.bindAll(this, 
                'gameCreateSuccess',
                
                'gameCreateError',
                'saveGameFacebookRequestId');
            $('form#new_game').live('ajax:success', this.gameCreateSuccess);
            $('form#new_game').live('ajax:error', this.gameCreateError);
        },
        gameCreateSuccess: function(e,response){
            this.set(response.model);
            $("<div></div>").html(response.message +
                "<br/><input type='checkbox' class='create_facebook_request'>Send Request via Facebook</input>")
            .dialog({
                buttons: {
                    Ok: function(){
                        if ($(this).find('input')[0].checked){
                            newGameView.sendFacebookGameRequest(response.message);
                        }
                        $(this).dialog("close");
                    }
                }
            });
        },
        gameCreateError: function(e, response){
            if (response.status == 201){
                //actually everythoing went ok, some $ bug doesn't like my JSON
                try {
                    var data = JSON.parse(response.responseText);
                    if (data.model){
                        this.gameCreateSuccess(e,data);
                        return;
                    }
                }
                catch(ex){
                    console.debug("Maybe actually something DID go wrong..." + ex);
                }
            }
            var error_messages=[];
            var errors_obj = $.parseJSON(response.responseText);
            _(errors_obj).each( function(errors,attribute){
                error_messages.push("-"+attribute+" " + errors.join(", "));
            });
            $("<div></div>").html(error_messages.join("/n"))
            .dialog(
            {
                title: 'Errors saving the game'
            }
            );

        },
        toggleSendFacebookRequest: function(){
            this.set({
                sendFacebookRequest: ! this.get("sendFacebookRequest")
            });
        },
        saveGameFacebookRequestId: function(requestIds){
            if (!requestIds) {
                console.log("FB:Request Error, did not receive request_ids");

            }
            console.log("FB:Request created, id:" + requestIds);
            if (requestIds.length == 0) {
                console.log("FB:Request response ERROR, no request id:" + requestIds);
                return;
            }
        }
        
    });

    window.NewGameView = Backbone.View.extend({
        el: "#new_game",
        
        initialize: function(){
            _.bindAll(this, 'render','sendFacebookGameRequest', 'toggleSendFacebookRequest','markPlaygroundInMap');
            $('input.create_facebook_request').live('click', this.toggleSendFacebookRequest);
            $('select#game_playground_id').bind('click', this.markPlaygroundInMap);
            $('div.team_selector.first_team_selector').flexbox('/teams/my.json', {
                watermark: "Select one of your teams",
                onSelect: this.selectTeamFromCombo,
                hiddenValue: 'id',
                width: 300,
                resultTemplate: '<div class="team_result_row">'+
            '<div class="mini_team_info_row"><h5>{name}</h5></div>'+
            '<img class="team_mini_image" src="{image_path}"></img></div>'
                                
            });
            $('div.team_selector.second_team_selector').flexbox('/teams.json', {
                watermark: "Select the rival team",
                onSelect: this.selectTeamFromCombo,
                width: 300,
                resultTemplate: '<div class="team_result_row">'+
            '<div class="mini_team_info_row"><h5>{name}</h5></div>'+
            '<img class="team_mini_image" src="{image_path}"></img></div>'
            });
            $('div.playground_selector').flexbox('/playgrounds.json', {
                watermark: "Select a playground",
                onSelect: this.markPlaygroundInMap
                
            });
            $('input[name="game[play_date]"]').datetimepicker({
                dateFormat: 'yy-mm-dd',
                timeFormat: 'hh:mm',
                stepHour: 1,
                stepMinute: 5
            });
            this.detectUserPositionAndpanMapTo();
        },
        detectUserPositionAndpanMapTo: function(){
            var lat_input = $('input.[name="player_latitude"]')[0];
            var lng_input = $('input.[name="player_longitude"]')[0];
            if (lat_input && lng_input){
                var coordinates = new google.maps.LatLng(
                    parseFloat(lat_input.value),
                    parseFloat(lng_input.value));
                var mapOptions = {
                    zoom: 13,
                    center: coordinates,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                this.map= new google.maps.Map($("#map")[0],mapOptions);
            }
        },
        selectTeamFromCombo: function(valueInput,idInput){
            var teamInfoPanel = $(valueInput.parentNode.parentNode).
                                 find("div.team_info_mini_panel");
            $.when($.ajax('/teams/' + idInput.value + ".json")).
                then(function(response){
                    teamInfoPanel.html(response);
            });

        },
        toggleSendFacebookRequest: function(e,value){
            this.model.toggleSendFacebookRequest();
        },
        markPlaygroundInMap: function(e,value){
            if (! this.map){
                var mapOptions = {
                    zoom: 13,
                    center: new google.maps.LatLng(43.35564,-8.389435),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                this.map= new google.maps.Map($("#map")[0],mapOptions);
            }
            var playground = $('input[name="game[playground_id]"]').val();
            $.ajax({
                url: "/playgrounds/" + playground +".json",
                type: 'GET',
                success: function(data, response){
                    var coordinates = new google.maps.LatLng(
                        parseFloat(data.latitude),
                        parseFloat(data.longitude));
                    newGameView.map.panTo( coordinates );
                    marker = new google.maps.Marker( {
                        position: coordinates,
                        map: newGameView.map
                    //title: place.get("full_address")
                    } );
                }
            });
        },
        render: function(){
            return this;
        },
        sendFacebookGameRequest: function(message){
            console.debug("FB:Request panel for Game:" +this.model.get('id'));
            var game = {
                description: this.model.get("description"),
                team1: this.model.get("team1"),
                team2: this.model.get("team2"),
                play_date: this.model.get("play_date")
            }
            var destination_players = _([game.team1.players[1]]).chain()
            .union(game.team2.players)
            .uniq();
                                        
            FB.ui({
                method: 'apprequests',
                to: destination_players.pluck('facebook_id'),
                message: message,
                data: 'tracking information for the user'
            },this.model.saveGameFacebookRequestId);
        }

    });
    window.newGame = new NewGame();
    window.newGameView = new NewGameView({
        model: window.newGame
    });
})