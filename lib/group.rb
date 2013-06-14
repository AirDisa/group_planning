class Group
  attr_accessor :going

  def initialize(array_of_invitees)
    @going = array_of_invitees
  end

  def solve
    get_rid_of_party_poopers
    filter_by_person_condition
    filter_by_person_condition while filter_by_count_condition
    going
  end

  def get_rid_of_party_poopers
    going.reject! { |invitee| invitee.status == "No" }
  end

  def filter_by_person_condition
    going.reject! { |invitee| required_person_not_going(invitee) }
  end

  def filter_by_count_condition
    going.reject! { |invitee| required_count_not_met(invitee) }
  end

  def required_person_not_going(invitee)
    invitee.conditions.any? { |cond|
      !going.map(&:user_id).include?(cond.value.to_i) if cond.method == "specific_person"
    }
  end

  def required_count_not_met(invitee)
    invitee.conditions.any? { |cond|
      going.length < cond.value.to_i if cond.method == "required_count"
    }
  end
end
