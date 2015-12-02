FactoryGirl.define  do
  factory :metric, class: KalibroClient::Entities::Miscellaneous::Metric do
    name "Afferent Connections per Class (used to calculate COF - Coupling Factor)"
    code "acc"
    type 'TestMetricSnapshot'
    scope :SOFTWARE

    initialize_with { new(type, name, code, scope) }
  end
end