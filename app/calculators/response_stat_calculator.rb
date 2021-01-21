class ResponseStatCalculator
  def response_data_by_month(organization, questionnaire)
    responses = Response.where("question_id = ? and team_member_id IN (?)",
                               questionnaire.question_ids[0], org_member_ids(organization))
    data = {}
    responses.each do |response|
      data[response.period_start] = { 'count' => 0, 'rate' => 0 } if data[response.period_start].nil?

      data[response.period_start]['count'] += 1
    end
    data.each do |key, values|
      data[key]['rate'] = (values['count'].to_f / member_count(organization)) * 100
    end
    data
  end

  private

  def org_member_ids(org)
    ids = []
    org.all_org_members.each do |member|
      ids.push(member.id)
    end
    ids
  end

  def member_count(organization)
    organization.all_org_members.count
  end
end
