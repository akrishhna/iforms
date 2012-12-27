class GirlScoutsFields < ActiveRecord::Base

  def self.get_all_fields(sp_id)
    service_provider = ServiceProvider.find(sp_id)
    mapping_field_name = service_provider.mapping_field_name
    all_fields = GirlScoutsFields.select("field_name,#{mapping_field_name}")
    fields = {}
    all_fields.each {|f| fields[f.field_name] = f[mapping_field_name] && f[mapping_field_name] != 'null' ? f[mapping_field_name] : false }
    return fields
  end
end
