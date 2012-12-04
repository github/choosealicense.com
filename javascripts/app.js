var qtip_position = {
  my: 'top center',
  at: 'bottom center'
};

$(document).ready(function() {
  $('table.license ul.required li').qtip({
    content: {
      text: false,
      title: {
        text: 'Required'
      }
    },
    position: qtip_position,
    style: {
      classes: 'qtip-shadow qtip-required'
    }
  });

  $('table.license ul.permitted li').qtip({
    content: {
      text: false,
      title: {
        text: 'Permitted'
      }
    },
    position: qtip_position,
    style: {
      classes: 'qtip-shadow qtip-permitted'
    }
  });

  $('table.license ul.forbidden li').qtip({
    content: {
      text: false,
      title: {
        text: 'Forbidden'
      }
    },
    position: qtip_position,
    style: {
      classes: 'qtip-shadow qtip-forbidden'
    }
  });
});