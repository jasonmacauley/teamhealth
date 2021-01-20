class Dashboard < ApplicationRecord
  has_many :dashboard_widgets
  has_many :widgets, through: :dashboard_widgets
  belongs_to :user

  def json
    as_json(include: {
        widgets: {
            include: {
                widget_configs: {
                    include: {
                        dashboard_widget_config_type: {
                            only: [:id, :name]
                        }},
                    except: :id
                    }
                },
            except: :id
            },
        },
            except: :id
    )
  end
end
