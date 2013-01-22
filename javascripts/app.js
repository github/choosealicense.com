var annotations = {
  permitted: {
    'commercial-use' : 'This software and derivatives may be used for commercial purposes.',
    'modifications' : 'This software may be modified.',
    'distribution' : 'You may distribute this software.',
    'sublicense' : 'You may grant a sublicense to modify and distribute this software to third parties not included in the license.',
    'warranty' : 'You may place a warranty on the software.',
    'private-use' : 'You may use and modify the software without distributing it.'
  },

  forbidden: {
    'no-warranty' : 'Software is released without warranty and the software/license owner cannot be charged for damages.',
    'trademark-use' : 'You may NOT use the names, logos, or trademarks of contributors.',
    'no-liability' : 'Software is provided without warranty and the software author/license owner cannot be held liable for damages.',
    'no-sublicense' : 'You may not grant a sublicense to modify and distribute this software to third parties not included in the license.',
  },

  required: {
    'include-copyright' : 'Include the original copyright with the code.',
    'include-license' : 'Include the full text of the license with the code.',
    'document-changes' : 'Indicate significant changes made to the code.',
    'disclose-source' : 'Source code must be made available when distributing the software.',
    'nonstatic-linkage' : 'The library must be linked in a way that allows it to be replaced with a similar library.',
    'rename' : 'You must change the name of the software if you modify it.'
  }
}

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