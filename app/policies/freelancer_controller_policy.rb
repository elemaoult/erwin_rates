class FreelancerControllerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def freelancer_expertises_data?
    true
  end

end
