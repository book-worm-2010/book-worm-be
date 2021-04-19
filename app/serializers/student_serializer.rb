class StudentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email
end
