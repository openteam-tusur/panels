class Manage::PermissionsController < Manage::ApplicationController
  private

  def permission_params
    params.require(:permission).permit(:user_id, :role, :context_id, :context_type)
  end

end
