class Admin::BanksController < Admin::BaseController
  before_action :set_bank, only: [:show, :edit, :update,:destroy]

  def index
    @banks = policy_scope(Bank)
  end

  def show
    authorize @bank
  end

  def new
    @bank = Bank.new
    authorize @bank
  end

  def edit
    authorize @bank
  end

  def create
    @bank = Bank.new(bank_params)
    authorize @bank
    if @bank.save
      flash[:success] = t('messages.created', model: @bank.class.model_name.human)
      redirect_to [:admin, @bank]
    else      
      render :new
    end
  end

  def update
    authorize @bank
    if @bank.update(bank_params)
      flash[:success] = t('messages.updated', model: @bank.class.model_name.human)
      redirect_to [:admin, @bank]
    else      
      render :edit
    end
  end

  def destroy
    authorize @bank
    @bank.destroy
    flash[:success] = t('messages.deleted', model: @bank.class.model_name.human)
    redirect_to admin_banks_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def bank_params
      params.require(:bank).permit(:name, :title, :brief_title, :legal_address, :postal_address, :phone, :email, :url, :corr_acc, :corr_acc_with, :bic, :inn, :kpp, :ogrn, :okpo, :okato, :comment, :status)
    end
end
