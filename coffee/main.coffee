GOOGLE_FORM_URL_NEWSLETTER = "https://docs.google.com/forms/d/1ALMyFSUVhwvHEtscS63-PemL68Nv5AeHSvyVCAOi3Ec/formResponse";
GOOGLE_FORM_INPUT_NEWSLETTER_EMAIL = "entry.598210959";

GOOGLE_FORM_URL_CONTACT = "https://docs.google.com/forms/d/1YlJNFq4UA5mU8nR3-Nplq5wcxK41pchzHM_cYX6jCOA/formResponse";
GOOGLE_FORM_INPUT_CONTACT_EMAIL = "entry.1858359110";
GOOGLE_FORM_INPUT_CONTACT_TEXT = "entry.1844475962";

$ () ->

 $ '.start-animation'
    .addClass 'animated bounceInDown'

 $ '.review-item'
   .gallery
     timeout: 8000
     fade_in: 1000
     fade_out: 1000

 $ '#screenshot-sm .screenshot-item'
   .gallery
     timeout: 8000
     fade_in: 600
     fade_out: 600

 $ '#screenshot-md .screenshot-item'
  .gallery
      timeout: 8000
      fade_in: 600
      fade_out: 600

 $ '#buy-btn, #buy-bottom-btn'
    .on 'click', ->
      ga 'send', 'event', 'buy', 'button',
        version: $('#download-btn').attr('version')
      return

 $ '#download-btn, #download-bottom-btn'
    .on 'click', ->
      ga 'send', 'event', 'download', 'button',
        version:$('#download-btn').attr('version')
      return

 timeout = null;

 $ '#contact-form'
    .submit (e) ->

      e.preventDefault()

      email_input = $(this).find('.email-input');
      text_input = $(this).find('.text-input');

      if !email_input.val() || !text_input.val()
        return;

      func = ((email_input, text_input, form, thank_you) ->

          clearTimeout(timeout);

          $(email_input).val('');
          $(text_input).val('');

          $ thank_you
           .removeClass 'hidden'

          $ form
            .addClass 'hidden'

          timeout = setTimeout ->

            $ thank_you
              .addClass 'hidden'

            $ form
              .removeClass 'hidden'

            return

          , 5000

          ga 'send', 'event', 'contactForm', 'button',
            version: $('#download-bottom-btn').attr('version')

          return

      ).bind(null, email_input, text_input, $(this), $('.contact-thanks-text'))

      data = {};
      data[GOOGLE_FORM_INPUT_CONTACT_EMAIL] = email_input.val();
      data[GOOGLE_FORM_INPUT_CONTACT_TEXT] = text_input.val();

      $.ajax
        url: GOOGLE_FORM_URL_CONTACT,
        data: data,
        type: "POST",
        dataType: "xml",
        statusCode:
          0: func
          200: func

      return

 $ '#newsletter-form'
   .submit (e) ->

     e.preventDefault();

     input = $(this).find('.email-input');

     if !input.val()
       return

     func = ((input, form, thank_you) ->
       $(input).val('');
       $(form).addClass('hidden');
       $(thank_you).removeClass('hidden');

       ga 'send', 'event', 'subscribe', 'button',
           version:$('#download-bottom-btn').attr('version')

       return

     ).bind(null, input, $(this), $('.thank-you-text'))

     data = {};
     data[GOOGLE_FORM_INPUT_NEWSLETTER_EMAIL] = input.val();

     $.ajax
        url: GOOGLE_FORM_URL_NEWSLETTER,
        data: data,
        type: "POST",
        dataType: "xml",
        statusCode:
          0: func
          200: func

     return
 return

(() ->

   $.fn.gallery = (options) ->

     setting = $.extend
        timeout: 10000
        fade_in: 2000
        fade_out: 2000
     , options

     i = 0

     this.each (key, item) ->
       if key > 0
         $(item).hide()

     this.removeClass 'hidden'

     anim = =>

       next = 0

       if i <  this.length - 1
         next = i+1;

       this.eq(i).fadeOut setting.fade_out, =>
         this.eq(next).fadeIn setting.fade_in

       if this.length == ++i
         i = 0

       run()

     run = ->
       setTimeout ->
         anim()
       , setting.timeout

     run() if this.length > 1

     this

)(jQuery)