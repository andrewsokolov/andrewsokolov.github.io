var GOOGLE_FORM_URL_NEWSLETTER = "https://docs.google.com/forms/d/1ALMyFSUVhwvHEtscS63-PemL68Nv5AeHSvyVCAOi3Ec/formResponse";
var GOOGLE_FORM_INPUT_NEWSLETTER_EMAIL = "entry.598210959";

var GOOGLE_FORM_URL_CONTACT = "https://docs.google.com/forms/d/1YlJNFq4UA5mU8nR3-Nplq5wcxK41pchzHM_cYX6jCOA/formResponse";
var GOOGLE_FORM_INPUT_CONTACT_EMAIL = "entry.1858359110";
var GOOGLE_FORM_INPUT_CONTACT_TEXT = "entry.1844475962";

$(function(){

    $('#logo img').on('mouseenter', function(){
       $(this).addClass('rotate-image');
    }).on('mouseout', function(){
        $(this).removeClass('rotate-image');
    });

    var status = true;

    setInterval((function(){

        if (status){
              $(this).addClass('snake-animation');
        } else {
              $(this).removeClass('snake-animation');
        }

        status = !status;

        setTimeout(function(){
            $(this).removeClass('snake-animation');
        }.bind(this), 2000)

    }).bind($('.download-btn')), 5000);

    $('#download-btn').on('click', function(){

        ga('send', 'event', 'download', 'button', {
            version:$('#download-btn').attr('version')
        });
    });

    $('#newsletter-form').submit(function(e){

        e.preventDefault();

        var input = $(this).find('.email-input');

        if (!input.val()){
            return;
        }

        var func = function(input, form, thank_you){
            $(input).val('');
            $(form).addClass('hidden');
            $(thank_you).removeClass('hidden');

            ga('send', 'event', 'subscribe', 'button', {
                version:$('#download-btn').attr('version')
            });

        }.bind(null, input, $(this), $('.thank-you-text'));

        var data = {};
            data[GOOGLE_FORM_INPUT_NEWSLETTER_EMAIL] = input.val();

        $.ajax({
            url: GOOGLE_FORM_URL_NEWSLETTER,
            data: data,
            type: "POST",
            dataType: "xml",
            statusCode: {
                0: func,
                200: func
            }
        });
    });

    var timeout = null;

    $('#contact-form').submit(function(e){

        e.preventDefault();

        var email_input = $(this).find('.email-input');
        var text_input = $(this).find('.text-input');

        if (!email_input.val() || !text_input.val()){
            return;
        }

        var func = function(email_input, text_input, thank_you){

            clearTimeout(timeout);

            $(email_input).val('');
            $(text_input).val('');

            $(thank_you).removeClass('hidden');

            timeout = setTimeout(function(){
                $(thank_you).addClass('hidden');
            }, 5000);

            ga('send', 'event', 'subscribe', 'button', {
                version:$('#download-btn').attr('version')
            });

        }.bind(null, email_input, text_input, $('.contact-thanks-text'));

        var data = {};
        data[GOOGLE_FORM_INPUT_CONTACT_EMAIL] = email_input.val();
        data[GOOGLE_FORM_INPUT_CONTACT_TEXT] = text_input.val();

        $.ajax({
            url: GOOGLE_FORM_URL_CONTACT,
            data: data,
            type: "POST",
            dataType: "xml",
            statusCode: {
                0: func,
                200: func
            }
        });
    });

});