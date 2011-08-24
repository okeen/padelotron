$(function() {
    window.Customer = Backbone.Model.extend({
        defaults: {
            name: ''
        },
        initialize: function(){
            _.bindAll(this,
                'customerCreateSuccess',
                'customerCreateError');
            $('form#new_customer').bind('ajax:success', this.customerCreateSuccess);
            $('form#new_customer').bind('ajax:error', this.customerCreateError);
        },
        customerCreateSuccess: function(){},
        customerCreateError: function(){}
    });
    
    window.CustomerView = Backbone.View.extend({
        el: "form#new_customer",
        customers: [],
        
        initialize: function(){
            _.bindAll(this, 'render');
            this.render();
        },
        render: function(){
            $("form#new_customer").formwizard({
                formPluginEnabled: true,
                focusFirstInput : true,
                formOptions :{
                    success: function(data){
                            alert("jhdsa");
                        },
                    beforeSubmit: function(data){
                        alert("jsfh");
                    },
                    dataType: 'json',
                    resetForm: true
                }
            })

        }
    });
    window.customer = new Customer();
    window.customerView = new CustomerView({
        model: window.customer
    });
})