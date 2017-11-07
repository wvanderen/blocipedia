class UsersController < ApplicationController
    def downgrade
        current_user.standard!
    end
    
    def upgrade
        current_user.premium!
    end
    
    protected
    
    def update_resource(resource, params)
        resource.update_without_password(params)
    end
end

