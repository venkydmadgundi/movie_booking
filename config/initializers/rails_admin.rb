RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.model User do
    list do
      fields :name, :email, :admin, :created_at
    end
  end
  
  config.model TimeSlot do
    list do
      fields :name, :start_time, :end_time, :created_at
    end
    create do
      fields :name, :start_time, :end_time
    end
  end

  config.model Show do
    list do
      field :id
      field :movie do
	pretty_value do
          value.try(:name)
        end
      end
      field :screen do
        pretty_value do
	  value.try(:name)
	end
      end
      field :time_slot do
	pretty_value do
  	  [value.try(:start_time).strftime("%I:%M %p"), value.try(:end_time).strftime("%I:%M %p")].join(' - ')
	end
      end
      fields :show_date, :available_seats, :seat_price, :created_at
    end
    create do
      field :movie
      field :screen
      field :time_slot do
      end
      fields :show_date, :available_seats, :seat_price
    end
  end

  config.model Screen do
    list do
      fields :name, :seats, :created_at
    end
    create do
      fields :name, :seats
    end
  end

  config.model Movie do
    list do
      fields :name, :director_name, :release_date, :is_active, :created_at
    end
    create do
      fields :name, :director_name, :release_date, :is_active
    end
  end

  config.model Booking do
    list do
      fields :user, :show, :seats, :total_price, :created_at, :status
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      only ["Movie", "Screen", "Show", "TimeSlot"]
    end
    export
    bulk_delete
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
