class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  after_action :verify_authorized, only: [:new, :destroy]
  after_action :verify_policy_scoped, only: :index

  def index
  	@admins = policy_scope(Admin)
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to backoffice_admins_path, notice: 'Administrador cadastrado com sucesso'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin.update(admin_params)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to backoffice_admins_path, notice: 'Administrador atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    authorize @admin
    admin_email = @admin.email
    #for rails inside notice is necessary "", not ''.
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "Administrador #{admin_email} apagado com sucesso"
    else
      render :index
    end
  end

  private

  def admin_params
    if password_blank?
      params[:admin].except!(:password, :password_confirmation)
    end

    if @admin.blank?
      params.require(:admin).permit(:name, :email, :role, :password, :password_confirmation)
    else
      params.require(:admin).permit(policy(@admin).permitted_attributes)
    end
  end

  def password_blank?
    params[:admin][:password].blank? &&
    params[:admin][:password_confirmation].blank?
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
