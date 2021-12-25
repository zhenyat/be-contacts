class Admin::PartnerBanksController < Admin::BaseController
  before_action :set_partner_bank, only: [:show, :edit, :update,:destroy]

  def index
    @partner_banks = policy_scope(PartnerBank)
  end

  def show
    authorize @partner_bank
  end

  def new
    @partner_bank = PartnerBank.new
    authorize @partner_bank
  end

  def edit
    authorize @partner_bank
  end

  def create
    @partner_bank = PartnerBank.new(partner_bank_params)
    authorize @partner_bank
    if @partner_bank.save
      flash[:success] = t('messages.created', model: @partner_bank.class.model_name.human)
      redirect_to [:admin, @partner_bank]
    else      
      render :new
    end
  end

  def update
    authorize @partner_bank
    if @partner_bank.update(partner_bank_params)
      flash[:success] = t('messages.updated', model: @partner_bank.class.model_name.human)
      redirect_to [:admin, @partner_bank]
    else      
      render :edit
    end
  end

  def destroy
    authorize @partner_bank
    @partner_bank.destroy
    flash[:success] = t('messages.deleted', model: @partner_bank.class.model_name.human)
    redirect_to admin_partner_banks_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_partner_bank
      @partner_bank = PartnerBank.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def partner_bank_params
      params.require(:partner_bank).permit(:partner_id, :bank_id, :account, :comment, :status)
    end
end
