class StudentBookSerializer
  include FastJsonapi::ObjectSerializer
  attributes :student_id, :book_id, :status
end
