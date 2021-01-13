class WidgetController < ApplicationController
  def index
    @widgets = Widget.all
  end

  def show
    @widget = Widget.find(params[:id])
  end

  def new
    @widget = Widget.new
    @widget_type = WidgetType.find(params[:id])
  end

  def edit
    @widget = Widget.find(params[:id])
    @widget_type = @widget.widget_type
  end

  def update
    @widget = Widget.new
    unless params[:commit].match(/Create/)
      @widget = Widget.find(params[:widget][:id])
    end
    @widget_type = WidgetType.find(params[:widget][:widget_type_id])
    @widget.name = params[:widget][:name]
    @widget.description = params[:widget][:description]
    @widget.widget_type_id = @widget_type.id
    @widget.save
    @widget_type.dashboard_widget_config_types.each do |config_type|
      next unless WidgetConfig.where(dashboard_widget_config_type: config_type.id,
                                     widget_id: @widget.id,
                                     value: params[:widget][config_type.label.to_sym]).empty?

      config = WidgetConfig.create(dashboard_widget_config_type_id: config_type.id,
                                   widget_id: @widget.id,
                                   value: params[:widget][config_type.label.to_sym])
      config.save
    end
    redirect_to(show_widget_path(@widget))
  end

  def delete
    @widget = Widget.find(params[:id])
    @widget.delete
    redirect_to(widget_index_path)
  end
end
