class CustomersController < ApplicationController
  before_action :set_customer, except: %i[index blacklist search]

  def index
    @customers = Customer.available
  end

  def edit; end

  def update
    if @customer.update(customer_params)   
      redirect_to root_path, notice: 'Клиент успешно обновлён!'
    else
      render :edit
    end
  end

  def do_black
    @customer.to_blacklist!

    redirect_to root_path
  end

  def do_white
    @customer.blacklist_off!

    redirect_to blacklist_path
  end

  def blacklist
    @black_customers = Customer.blocked
  end

  def search
    if phone.blank?
      redirect_to(blacklist_path, alert: "Поле для поиска не заполнено!")
    elsif customer_by_phone.blank?
      redirect_to(blacklist_path, alert: "Клиент не найден!")
    else
      customer_by_phone.update!(blacklisted: true)
      redirect_to(blacklist_path, alert: "Клиент успешно добавлен в чёрный список!")
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id]) || params[:customer_id]
  end


  def customer_params
    params.require(:customer).permit(:name, :phone,
                                     :description, :blacklisted)
  end

  def customer_by_phone
    Customer.search(phone)
  end

  def phone
    params[:phone]
  end
end
