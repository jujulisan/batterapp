class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]

  def index
  	@admins = Admin.all
  end

  def new
    @admin = Admin.new
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
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
