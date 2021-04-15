namespace :export_all do
  desc 'Prints all db records in a seeds.rb way'
  task :seeds_format => :environment do
    Rails.application.eager_load!
    ActiveRecord::Base.descendants.each do |model|
      next if model.to_s =~ /Application/

      begin
        model.order(:id).all.each do |record|
          puts "#{model.to_s}.create(#{record.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
        end
      rescue
        next
      end
    end
  end
end
