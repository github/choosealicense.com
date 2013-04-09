var qtip_position = {
  my: 'top center',
  at: 'bottom center'
};

$(document).ready(function() {
  for (var category in annotations) {
    var categoryAnnotations = annotations[category];
    for (var annotation in categoryAnnotations) {
      $('.license-rules ul.license-' + category + ' li.' + annotation).attr('title', categoryAnnotations[annotation]);
    }
  }

  $('.license-required li').qtip({
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

  $('.license-permitted li').qtip({
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

  $('.license-forbidden li').qtip({
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