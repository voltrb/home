class SharedController < ModelController
  def active?(page)
    (params._action.or('') == page).or((params._controller == 'docs').and(page == 'docs'))
  end
end