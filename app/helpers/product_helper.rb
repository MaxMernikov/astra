module ProductHelper
  def info_class1(boolean)
    return 'col-sm-5 col-md-3' if boolean
    'col-sm-4 col-md-3 col-md-offset-1'
  end

  def info_class2(boolean)
    return 'col-sm-5 col-sm-offset-1 col-md-3 col-md-offset-0' if boolean
    'col-sm-4 col-md-4'
  end

  def info_class3(boolean)
    return 'col-sm-5 col-md-3' if boolean
    'col-sm-4 col-md-3'
  end
end