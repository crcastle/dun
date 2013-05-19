#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require twitter/bootstrap
#= require sync
#= require_tree .


class Sync.AccomplishmentListRow extends Sync.View

  # beforeUpdate: (html, data) ->
    # @$el.fadeOut => @update(html)

  afterUpdate: ->
    @$el.effect("highlight",{color:"lightyellow"},1000)

  beforeRemove: ->
    @$el.css('background-color', 'indianred')
    @$el.fadeOut 'slow', => @remove()
