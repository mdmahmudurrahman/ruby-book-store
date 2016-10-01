$ -> if $('.checkout-show').length > 0
  $('.book-description').dotdotdot()

$ -> if $('div[step="address"]').length > 0
  $('input[name="as-billing-address"]').click () ->
    $('.shipping-address-fields').slideToggle()
