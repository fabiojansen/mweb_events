
window.isOnPage = (controller, action='') ->
  if action is ''
    return $('body').is ".#{controller}"
  else
    actions = action.split("|")
    for act in actions
      if $('body').is ".#{controller}.#{act}"
        return true
    return false