@Accomplishment =

  init: -> @bind()

  bind: ->
    $("[data-name=new-accomplishment-form]").on 'ajax:complete', -> @reset()
    $("[data-name=accomplishments-list]").on "click", "[data-action=edit-accomplishment]", (e) =>
      e.preventDefault()
      @toggleEditRow $(e.target).parents("[data-name=accomplishment-row]")


  toggleEditRow: ($parentRow) ->
    $parentRow.addClass("edit")
    $parentRow.find("input[type=text]").focus()



$ ->
  Accomplishment.init()
