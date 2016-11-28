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
    # For just change email and don't be necessary type password
    passwd = params[:admin][:password]
    passwd_con = params[:admin][:password_confirmation]

    if passwd.blank? && passwd_con.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(admin_params)
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
    params.require(:admin).permit(policy(@admin).permitted_attributes)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
