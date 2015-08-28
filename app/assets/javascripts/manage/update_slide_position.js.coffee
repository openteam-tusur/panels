$ ->
  if $('#sortable').length > 0
    table_width = $('#sortable').width()
    cells = $('.table').find('tr')[0].cells.length
    desired_width = table_width / cells + 'px'
    $('.table td').css('width', desired_width)

    $('#sortable').sortable(
      axis: 'y'
      items: '.item'
      cursor: 'move'
      handle: '.handler'
      containment: 'table'

      sort: (e, ui) ->
        ui.item.addClass('active-item-shadow')
      stop: (e, ui) ->
        ui.item.removeClass('active-item-shadow')
        # highlight the row on drop to indicate an update
        ui.item.children('td').effect('highlight', {}, 1000)
      update: (e, ui) ->
        slides = {}
        $('tr.item', $(ui.item.context).closest('table')).each (index, item) ->
          slides[$(item).data('item-id')] = index
          return
        $.ajax(
          type: 'POST'
          url: window.location.pathname + '/update_position'
          dataType: 'json'
          data: { slides: slides }
        )
    )
