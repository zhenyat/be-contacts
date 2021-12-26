class Admin::PartnersController < Admin::BaseController
  before_action :set_partner, only: [:show, :edit, :update,:destroy]

  def index
    @partners = policy_scope(Partner)
  end

  def show
    authorize @partner
  end

  def new
    @partner = Partner.new
    @partner.partner_banks.build.build_bank
    authorize @partner
  end

  def edit
    @partner.partner_banks.build.build_bank
    authorize @partner
  end

  def create
    @partner = Partner.new(partner_params)
    authorize @partner
    if @partner.save
      flash[:success] = t('messages.created', model: @partner.class.model_name.human)
      redirect_to [:admin, @partner]
    else      
      render :new
    end
  end

  def update
    authorize @partner
    if @partner.update(partner_params)
      flash[:success] = t('messages.updated', model: @partner.class.model_name.human)
      redirect_to [:admin, @partner]
    else      
      render :edit
    end
  end

  def destroy
    authorize @partner
    @partner.destroy
    flash[:success] = t('messages.deleted', model: @partner.class.model_name.human)
    redirect_to admin_partners_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_partner
      @partner = Partner.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def partner_params
      params.require(:partner).permit(
        :name, :code, :title, :kind, :role, :email, :url, :inn, :kpp, :ogrn, :ogrnip, :okpo, :okato, :certificate_number, :certificate_date, :status, :comment, :cover_image, :remove_cover_image, images: [],
        partner_banks_attributes: [:id, :account, :comment, :bank_id, bank_attributes: [:id, :title]]
      )
    end
end
# params.require(:patient).permit(:id, :name, appointments_attributes: [:id, :appointment_date, :doctor_id])
