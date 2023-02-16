class ProductsQuery

  def initialize(params, product = Product.all)
    @params = params
    @product = product
  end

  def call
    query_list = @product
    query_list = by_section(query_list) if check_section() == true
    query_list = by_kind(query_list) if check_kind() == true
    query_list = by_brand(query_list) if check_kind() and check_section() == false
    return query_list
  end

  def by_brand(query_list)
    query_list.where(brand: @params[:params], available: true)
  end

  def by_section(query_list)
    query_list.where(section: @params[:params], available: true)
  end

  def by_kind(query_list)
    query_list.where(section: @params[:params], available: true)
  end

  def check_section()
    Product.sections.each do |check|
      if check.include?(@params[:params]) then return true end
    end
  end

  def check_kind()
    Product.kinds.each do |check|
      if check.include?(@params[:params]) then return true end
    end
  end

end