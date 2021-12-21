class Admin::PhonesController < Admin::BaseController
  before_action :set_phone, only: [:show, :edit, :update,:destroy]

  def index
    @phones = policy_scope(Phone)
  end

  def show
    authorize @phone
  end

  def new
    @phone = Phone.new
    authorize @phone
  end

  def edit
    authorize @phone
  end

  def create
    @phone = Phone.new(phone_params)
    authorize @phone
    if @phone.save
      flash[:success] = t('messages.created', model: @phone.class.model_name.human)
      redirect_to [:admin, @phone]
    else      
      render :new
    end
  end

  def update
    authorize @phone
    if @phone.update(phone_params)
      flash[:success] = t('messages.updated', model: @phone.class.model_name.human)
      redirect_to [:admin, @phone]
    else      
      render :edit
    end
  end

  def destroy
    authorize @phone
    @phone.destroy
    flash[:success] = t('messages.deleted', model: @phone.class.model_name.human)
    redirect_to admin_phones_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def phone_params
      params.require(:phone).permit(:number, :kind, :status)
    end
end
